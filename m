Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270848AbTHGVWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270863AbTHGVWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:22:33 -0400
Received: from public1-brig1-3-cust85.brig.broadband.ntl.com ([80.0.159.85]:8625
	"EHLO ppg_penguin.kenmoffat.uklinux.net") by vger.kernel.org
	with ESMTP id S270848AbTHGVWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:22:31 -0400
Date: Thu, 7 Aug 2003 22:22:30 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-rc1 breaks dri in X-4.3.0
In-Reply-To: <Pine.LNX.4.44.0308071708390.4303-100000@logos.cnet>
Message-ID: <Pine.LNX.4.56.0308072211060.9722@ppg_penguin>
References: <Pine.LNX.4.44.0308071708390.4303-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, Marcelo Tosatti wrote:

>
>
> On Thu, 7 Aug 2003, Ken Moffat wrote:
>
> >  Apologies if this is a known bug, I'm slightly lost following the list,
> > and the only bug I can see mentioned seems to be in Alan's tree.
> >
> >  I've just built 2.4.22-rc1 for my PIII (via chipset, radeon 7500), and
> > rebuilt radeon.o from the X 4.3 release.  This combination worked with
> > 2.4.22-pre7 (although with occasional X lock-ups).
> >
> >  In X's log I can see that the radeon module fails to open
> > /dev/dri/card0 (no such device) and therefore the module load fails.
> >
> >  From dmesg I can see that agpgart detects the chipset and reports the
> > aperture,  but there are zero [drm] messages following.
>
> Does the DRM module get loaded?
>
> Whats the output of insmod drm.o ?
>

 drm is built in, only radeon.o is a module.  Bizarrely (I rebooted
before the original mail, in case something was hanging on to a file and
stopping it loading), this time it loads.

insmod radeon now gives me
[drm] AGP 0.99 aperture @ 0xe8000000 64MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0

It looks as if I had a problem with depmod, insmod was failing until I
reran depmod -a, and yet that is at the end of my script for rebuilding
the X modules.  Sorry this turns out to be a bogus report.

Ken
-- 
 I never wanted to be a tester.  I wanted to be a lumberjack...



