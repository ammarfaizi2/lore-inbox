Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbULRN0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbULRN0J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 08:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbULRN0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 08:26:09 -0500
Received: from piglet.wetlettuce.com ([82.68.149.69]:56448 "EHLO
	piglet.wetlettuce.com") by vger.kernel.org with ESMTP
	id S262255AbULRN0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 08:26:04 -0500
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
From: Mark Broadbent <markb@wetlettuce.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20041217233524.GA11202@electric-eye.fr.zoreil.com>
References: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com>
	 <20041216211024.GK2767@waste.org>
	 <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com>
	 <20041217215752.GP2767@waste.org>
	 <20041217233524.GA11202@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 18 Dec 2004 13:25:12 +0000
Message-Id: <1103376312.5196.0.camel@tigger>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MailScanner: Mail is clear of Viree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-18 at 00:35 +0100, Francois Romieu wrote:
> Matt Mackall <mpm@selenic.com> :
> [...]
> > Please try the attached untested, uncompiled patch to add polling to
> > r8169:
> [...]
> > @@ -1839,6 +1842,15 @@
> >  }
> >  #endif
> >  
> > +#ifdef CONFIG_NET_POLL_CONTROLLER
> > +static void rtl8169_netpoll(struct net_device *dev)
> > +{
> > +	disable_irq(dev->irq);
> > +	rtl8169_interrupt(dev->irq, netdev, NULL);
>                                     ^^^^^^ -> should be "dev"
> 
> The r8169 driver in -mm offers netpoll. A patch which syncs the r8169
> driver from 2.6.10-rc3 with current -mm is available at:
> http://www.fr.zoreil.com/people/francois/misc/20041218-2.6.10-rc3-r8169.c-test.patch
> 
> Please report success/failure. Cc: netdev@oss.sgi.com is welcome.

Will try -mm when I next have access to the hardware (on Monday) and
will report back.

Thanks
Mark

> --
> Ueimor
> 
-- 
Mark Broadbent <markb@wetlettuce.com>
