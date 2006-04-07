Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWDGVHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWDGVHs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWDGVHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:07:48 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:13217 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964957AbWDGVHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:07:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: 2.6.17-rc1: bcm43xx problems with BCM4306 on x86_64
Date: Fri, 7 Apr 2006 23:08:37 +0200
User-Agent: KMail/1.9.1
Cc: bcm43xx-dev@lists.berlios.de, LKML <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
References: <200604071859.23452.rjw@sisk.pl> <200604072105.53994.mb@bu3sch.de>
In-Reply-To: <200604072105.53994.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072308.38233.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 21:05, Michael Buesch wrote:
> On Friday 07 April 2006 18:59, Rafael J. Wysocki wrote:
> > I've just tried the version of the driver included in 2.6.17-rc1 on an
> > x86_64 box (Asus L5D) with a built-in PCI BCM4306 adapter (Broadcom
> > Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 03)), and
> > unfortunately it doesn't seem to work.
> >
> > The driver loads and seems to initialize the adapter, but that's all,
> > apparently.
> >
> > First, I compiled the driver with DMA and PIO support, but it hanged my box
> > solid when I tried "iwconfig eth1 essid on" on it.  On the next boot I
> > noticed it caused the following messages to appear in dmesg:
> >
> > nommu_map_single: overflow 58ee7010+2404 of device mask 3fffffff
> > nommu_map_single: overflow 53669010+2404 of device mask 3fffffff
> > nommu_map_single: overflow 50180010+2404 of device mask 3fffffff
> 
> You should probably report that to the x86_64 people.

I'll try -mm first and report if this still happens there.

> > and so on, down to 455aa010.  Then I thought the adapter might be unable
> > to DMA for some reason and compiled it with PIO support only.  It did not
> > hang the box any more, but I couldn't make it work.
> 
> PIO does not work, yet. Give me some other few weeks, please.

Oops.  Sorry for the noice then. ;-)

Greetings,
Rafael
