Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161199AbWBTXgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbWBTXgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 18:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161200AbWBTXgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 18:36:21 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:3457 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161199AbWBTXgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 18:36:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc4-mm1 kernel crash at bootup. parport trouble?
Date: Tue, 21 Feb 2006 00:36:30 +0100
User-Agent: KMail/1.9.1
Cc: MIke Galbraith <efault@gmx.de>, helge.hafting@aitel.hist.no,
       linux-kernel@vger.kernel.org
References: <20060220042615.5af1bddc.akpm@osdl.org> <1140449123.7563.2.camel@homer> <20060220124122.1a38a065.akpm@osdl.org>
In-Reply-To: <20060220124122.1a38a065.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602210036.30836.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 21:41, Andrew Morton wrote:
> MIke Galbraith <efault@gmx.de> wrote:
> >
> > On Mon, 2006-02-20 at 16:07 +0100, Helge Hafting wrote:
> >  > pentium IV single processor, gcc (GCC) 4.0.3 20060128
> >  > 
> >  > During boot, I normally get:
> >  > parport0: irq 7 detected
> >  > lp0: using parport0 (polling).
> >  > 
> >  > Instead, I got this, written by hand:
> > 
> >  ........
> > 
> >  > This oops is simplified. I can get the exact text if
> >  > that really matters.  It is much more to write down and
> >  > I don't usually have my camera at work.
> > 
> >  I get the same, and already have the serial console hooked up.
> > 
> >  BUG: unable to handle kernel NULL pointer dereference at virtual address 000000e8
> 
> Thanks.  Could someone try reverting
> register-sysfs-device-for-lp-devices.patch?

That helps on my system.

An unrelated problem is that USB host drivers (ohci-hcd, ehci-hcd) refuse to
suspend.  [Investigating ...]

Rafael
