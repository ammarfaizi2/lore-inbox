Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUBYB3T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbUBYB3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:29:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:4003 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262360AbUBYB2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:28:48 -0500
Date: Tue, 24 Feb 2004 17:28:45 -0800
From: Greg KH <greg@kroah.com>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, boutcher@us.ibm.com,
       Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: new driver (hvcs) review request and sysfs questions
Message-ID: <20040225012845.GA3909@kroah.com>
References: <1077667227.21201.73.camel@SigurRos.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077667227.21201.73.camel@SigurRos.rchland.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 06:00:26PM -0600, Ryan Arnold wrote:
> An example of the vio bus's "devices" sysfs directory is shown below.
> 
> Pow5:/sys/bus/vio/devices # ls
> .               l-lan@3000000c  l-lan@30000010       vty-server@30000004
> ..              l-lan@3000000d  rtc@4001             vty@30000000
> IBM,sp@4000     l-lan@3000000e  v-scsi@30000002
> l-lan@3000000b  l-lan@3000000f  vty-server@30000003

At first glance, why are you using text strings as part of your bus ids?
Bus ids must be unique, so it looks like you can do this by just using
the number after the '@' character, right?

Then, within each device on the bus, you can give it a "name" or "type"
if you want.  You can put the "l-lan", "rtc", "vty*" stuff there, and
not encode it in the bus id (which is not where it belongs.)

> P.S. who is maintainer of the char device tree?

Do you mean /drivers/char?  Not really anyone directly.  Do you have
some char drivers that need to get added there?  What type of drivers
are they?

thanks,

greg k-h
