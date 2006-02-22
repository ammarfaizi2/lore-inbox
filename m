Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWBVLog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWBVLog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWBVLog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:44:36 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:25229 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750780AbWBVLof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:44:35 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc4-mm1 kernel crash at bootup. parport trouble?
Date: Wed, 22 Feb 2006 12:44:33 +0100
User-Agent: KMail/1.9.1
Cc: efault@gmx.de, helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org,
       "Bernhard R. Link" <brlink@debian.org>
References: <20060220042615.5af1bddc.akpm@osdl.org> <20060220154025.0b547085.akpm@osdl.org> <200602210102.47371.rjw@sisk.pl>
In-Reply-To: <200602210102.47371.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602221244.33770.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 01:02, Rafael J. Wysocki wrote:
> On Tuesday 21 February 2006 00:40, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > On Monday 20 February 2006 21:41, Andrew Morton wrote:
> > > > MIke Galbraith <efault@gmx.de> wrote:
> > > > >
> > > > > On Mon, 2006-02-20 at 16:07 +0100, Helge Hafting wrote:
> > > > >  > pentium IV single processor, gcc (GCC) 4.0.3 20060128
> > > > >  > 
> > > > >  > During boot, I normally get:
> > > > >  > parport0: irq 7 detected
> > > > >  > lp0: using parport0 (polling).
> > > > >  > 
> > > > >  > Instead, I got this, written by hand:
> > > > > 
> > > > >  ........
> > > > > 
> > > > >  > This oops is simplified. I can get the exact text if
> > > > >  > that really matters.  It is much more to write down and
> > > > >  > I don't usually have my camera at work.
> > > > > 
> > > > >  I get the same, and already have the serial console hooked up.
> > > > > 
> > > > >  BUG: unable to handle kernel NULL pointer dereference at virtual address 000000e8
> > > > 
> > > > Thanks.  Could someone try reverting
> > > > register-sysfs-device-for-lp-devices.patch?
> > > 
> > > That helps on my system.
> > 
> > OK, thanks.  I'll drop it.
> > 
> > > An unrelated problem is that USB host drivers (ohci-hcd, ehci-hcd) refuse to
> > > suspend.  [Investigating ...]
> > 
> > Me too.
> > 
> > Try reverting reset-pci-device-state-to-unknown-after-disabled.patch.
> 
> Heh, that actually helps. :-)

Well, after reverting the reset-pci-device-state-to-unknown-after-disabled.patch
my usb controllers actually suspend, but they don't seem to resume properly
(eg. the USB mouse I am addicted to doesn't work after resume).

Greetings,
Rafael
