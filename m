Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285318AbRLFXq0>; Thu, 6 Dec 2001 18:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285315AbRLFXqR>; Thu, 6 Dec 2001 18:46:17 -0500
Received: from ns.suse.de ([213.95.15.193]:25352 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285312AbRLFXqE>;
	Thu, 6 Dec 2001 18:46:04 -0500
Date: Fri, 7 Dec 2001 00:46:00 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Christian Lavoie <clavoie@bmed.mcgill.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-pre5 will not boot
In-Reply-To: <20011206222352Z285255-21104+1594@vger.kernel.org>
Message-ID: <Pine.LNX.4.33.0112070040380.4486-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Christian Lavoie wrote:

> 2.4.17-pre5 + ext3-2.4.17-pre2 will not boot on a Cyrix 6x86 P150+ (133mhz)
> with 64 megs of RAM (I believe the bios to be an AwardBIOS)
>
> Backing out all changes in arch/i386/kernel (changes from pre4 to pre5)
> allows to boot again. (I'm now writing this under -pre5 on the machine in
> question)

This doesn't make a lot of sense, as..

1. the dmi_scan changes shouldn't apply to your system unless you've
   found a way to crowbar a 6x86 into a board with a l440GX chipset.
2. The Athlon SSE support is in an Athlon only path, so that never gets
   run on your box
3. The P4 HT support is in CONFIG_SMP ifdefs, so never even got compiled
   in.  Likewise the smpboot.c changes.

*stumped*.
Can you rebuild from a clean tarball, patch straight up to pre5
and try and reproduce this ? I'm betting it won't happen and you had
some cruft from an old build making things go awry.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

