Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbUDFSoS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbUDFSoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:44:18 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:64413 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S263957AbUDFSoL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:44:11 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: Dave Jones <davej@redhat.com>, Bjoern Michaelsen <bmichaelsen@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Date: Tue, 6 Apr 2004 20:44:06 +0200
User-Agent: KMail/1.6.1
References: <20040406031949.GA8351@lord.sinclair> <200404062004.34413.volker.hemmann@heim10.tu-clausthal.de> <20040406181146.GH6930@redhat.com>
In-Reply-To: <20040406181146.GH6930@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404062044.06533.volker.hemmann@heim10.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 April 2004 20:11, Dave Jones wrote:
> On Tue, Apr 06, 2004 at 08:04:34PM +0200, Hemmann, Volker Armin wrote:
>  > Now I did, what I should have done at the first place, dmesg:
>  >
>  > Linux agpgart interface v0.100 (c) Dave Jones
>  > agpgart: Detected SiS 746 chipset
>  > agpgart: Maximum main memory to use for agp memory: 439M
>  > agpgart: unable to determine aperture size.
>  > agpgart: agp_backend_initialize() failed.
>  > agpgart-sis: probe of 0000:00:00.0 failed with error -22
>
> something isn't right here. this takes us right back to where we
> were before your first email about this problem.
> Did the patch definitly apply to the tree you compiled ?
> Not booted into the wrong kernel by mistake ?

I made sure, that I am booted 2.6.5, removed /usr/src/linux-2.6.5, 
and /lib/modules/2.6.5, unpacked the tarball by hand, in case the ebuild did 
some patching, made a symlink with ln -s linux-2.6.5 linux and cd'ed into 
linux.
There I copied agpgart-2004-04-06.diff into /usr/src/linux and applied it with 
patch -p1 < agpgart-2004-04-06.diff

It said, that it was applied against sis, intel, efficion and via (not this 
order..) and I found no *.rej files, while the supposed to be patched files 
had an actual timestamp.

After that I copied over my .config from 2.6.5-rc3, made make oldconfig, 
without any problems, and make all modules_install install after that.
Grub points to vmlinuz, so everything fine there.

I rebooted.
Same error, uname -r:
Linux energy.heim10.tu-clausthal.de 2.6.5 #1 Tue Apr 6 20:26:45 CEST 2004 i686 
AMD Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux

So yes, I am pretty sure, that I am innocent ;o)

Glück Auf
Volker

-- 
Conclusions 
 In a straight-up fight, the Empire squashes the Federation like a bug. Even 
with its numerical advantage removed, the Empire would still squash the 
Federation like a bug. Accept it. -Michael Wong 
