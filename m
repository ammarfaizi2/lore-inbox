Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263933AbUDFSEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263936AbUDFSEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:04:47 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:29325 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S263933AbUDFSEh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:04:37 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: Dave Jones <davej@redhat.com>, Bjoern Michaelsen <bmichaelsen@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Date: Tue, 6 Apr 2004 20:04:34 +0200
User-Agent: KMail/1.6.1
References: <20040406031949.GA8351@lord.sinclair> <20040406134709.GB32405@redhat.com>
In-Reply-To: <20040406134709.GB32405@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404062004.34413.volker.hemmann@heim10.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 April 2004 15:50, Dave Jones wrote:
> On Tue, Apr 06, 2004 at 05:19:49AM +0200, Bjoern Michaelsen wrote:
>  > I wrote a patch against 2.6.5 to let the SiS 746 take advantage
>  > of the SiS 648 patches too.
>  > http://bugzilla.kernel.org/show_bug.cgi?id=2327
>
> That and a few others are in the pending queue which I'll push
> when Linus gets back. See
> http://www.codemonkey.org.uk/projects/bitkeeper/agpgart/ for the
> patch-of-the-day from bk://linux-dj.bkbits.net/agpgart
>
> In particular theres an additional fix for SiS users, I broke
> AGPv2 support in the previous fix that went into 2.6.5
>
> 		Dave

I tried your diff from codemonkey.org against 2.6.5. witch patch -p1 < 
your.diff in /usr/src/linux. It applied and compiled, but after the reboot, 
testgart failed:
bash-2.05b$ testgart
open: No such file or directory

I reinstalled the nvidia drivers, started X, looked 
into /proc/drivers/nvidia/agp/status: disabled.

Now I did, what I should have done at the first place, dmesg:

Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 746 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
agpgart-sis: probe of 0000:00:00.0 failed with error -22

I am rebooting after the mail back to 2.6.5-rc3 with the 'old' patches from 
last week, because even 2D is real slow now...

Glück Auf,
Volker 

-- 
Conclusions 
 In a straight-up fight, the Empire squashes the Federation like a bug. Even 
with its numerical advantage removed, the Empire would still squash the 
Federation like a bug. Accept it. -Michael Wong 
