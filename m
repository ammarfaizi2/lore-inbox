Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268958AbRHLFT1>; Sun, 12 Aug 2001 01:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268961AbRHLFTS>; Sun, 12 Aug 2001 01:19:18 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:63503 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268958AbRHLFTL>; Sun, 12 Aug 2001 01:19:11 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Booting from USB floppy?
Date: 11 Aug 2001 22:19:05 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9l53k9$b4q$1@cesium.transmeta.com>
In-Reply-To: <E15VlgK-0005GO-00@trixia.ai.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E15VlgK-0005GO-00@trixia.ai.mit.edu>
By author:    Chris Hanson <cph@zurich.ai.mit.edu>
In newsgroup: linux.dev.kernel
>
> I have been trying to build Debian 2.2 boot/root floppies for the HP
> OmniBook 500 laptop, which (in some configurations) has only a USB
> floppy drive.  I've been unable to get the kernel to load the root
> floppy.  These tests were done using Linux 2.4.6.
> 
> At this point, I think this isn't possible without some real work in
> the kernel.  I'd like to get some feedback about whether this is a
> correct deduction.  To that end, here is my analysis.
> 

Basically, this is yet another reason why THE FLOPPY DRIVE MAGIC
STUFF IN THE KERNEL IS OBSOLETE AND BROKEN.  There is absolutely no
sane reason to keep that crap around; the only sane way is to have an
initrd or similar thing (like viro's initramfs) set up a ramfs
initialized from whatever; the floppy stuff in the kernel should just
be nuked.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
