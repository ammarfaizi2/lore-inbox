Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWISWDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWISWDl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWISWDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:03:41 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:29337 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751187AbWISWDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:03:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc7-mm1: networking breakage on HPC nx6325 + SUSE 10.1
Date: Wed, 20 Sep 2006 00:06:52 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Greg KH <greg@kroah.com>
References: <20060919012848.4482666d.akpm@osdl.org> <20060919133606.f0c92e66.akpm@osdl.org> <200609192330.34769.rjw@sisk.pl>
In-Reply-To: <200609192330.34769.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609200006.53138.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 19 September 2006 23:30, Rafael J. Wysocki wrote:
> On Tuesday, 19 September 2006 22:36, Andrew Morton wrote:
> > On Tue, 19 Sep 2006 22:25:21 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > > - It took maybe ten hours solid work to get this dogpile vaguely
> > > >   compiling and limping to a login prompt on x86, x86_64 and powerpc. 
> > > >   I guess it's worth briefly testing if you're keen.
> > > 
> > > It's not that bad, but unfortunately the networking doesn't work on my system
> > > (HPC nx6325 + SUSE 10.1 w/ updates, 64-bit).  Apparently, the interfaces don't
> > > get configured (both tg3 and bcm43xx are affected).
> > 
> > Is there anything interesting in the dmesg output?
> 
> Not to me. :-)
>  
> > Perhaps an `strace -f ifup' or whatever would tell us what's failing.
> 
> Well, I can configure the interfaces manually, with ifconfig, but the SUSE's
> configuration tools don't work.  For example, "ifup eth0" tells me that
> "No configuration found for eth0" and that's all.
> 
> Also, powersaved segfaults at startup so I think the problem is with hal
> vs sysfs (again).
> 
> The output of dmesg after a fresh boot and the "strace ifup eth0" output
> are attached.

I _guess_ the problem is caused by
gregkh-driver-network-class_device-to-device.patch, but I can't verify this,
because the kernel (obviously) doesn't compile if I revert it.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
