Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVCZEBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVCZEBl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 23:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVCZEBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 23:01:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:52106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbVCZD7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:59:50 -0500
Date: Fri, 25 Mar 2005 19:58:46 -0800
From: Chris Wright <chrisw@osdl.org>
To: Hua Zhong <hzhong@cisco.com>
Cc: "'Chris Wright'" <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.6
Message-ID: <20050326035846.GX30522@shell0.pdx.osdl.net>
References: <20050326034142.GW30522@shell0.pdx.osdl.net> <200503260347.AXR12129@mira-sjc5-e.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503260347.AXR12129@mira-sjc5-e.cisco.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hua Zhong (hzhong@cisco.com) wrote:
>  >  int bt_sock_unregister(int proto)
> >  {
> > -	if (proto >= BT_MAX_PROTO)
> > +	if (proto < 0 || proto >= BT_MAX_PROTO)
> >  		return -EINVAL;
> 
> Just curious: would it be better to say
> 
> if ((unsigned int)proto >= BT_MAX_PTORO)

the first check makes it painfully obvious what it's checking.  i think
it's a wash (-O2 seems to collapse to the same check), with a win for
readability.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
