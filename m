Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUDHRys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUDHRys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:54:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:31947 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262100AbUDHRyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:54:45 -0400
Date: Thu, 8 Apr 2004 10:54:40 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, Nick.Holloway@pyrites.org.uk
Subject: Re: [PATCH 2.6] Add missing MODULE_PARAM to dummy.c (and MAINTAINERShip)
Message-ID: <20040408105440.G22989@build.pdx.osdl.net>
References: <20040408174823.GA13335@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040408174823.GA13335@localhost>; from linux-kernel@24x7linux.com on Thu, Apr 08, 2004 at 07:48:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jose Luis Domingo Lopez (linux-kernel@24x7linux.com) wrote:
> diff -Nrup linux-2.6.5/drivers/net/dummy.c linux-2.6.5-new/drivers/net/dummy.c
> --- linux-2.6.5/drivers/net/dummy.c	2004-04-04 17:45:54.000000000 +0200
> +++ linux-2.6.5-new/drivers/net/dummy.c	2004-04-08 19:23:23.000000000 +0200
> @@ -89,7 +89,8 @@ static struct net_device_stats *dummy_ge
>  static struct net_device **dummies;
>  
>  /* Number of dummy devices to be set up by this module. */
> -module_param(numdummies, int, 0);
> +MODULE_PARM(numdummies, "i");
> +MODULE_PARM_DESC(numdummies, "Maximum number of dummy devices (defaults to one)");

this is going backwards.  module_param is the newer (preferred) interface.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
