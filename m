Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288991AbSANTa0>; Mon, 14 Jan 2002 14:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288992AbSANT3L>; Mon, 14 Jan 2002 14:29:11 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:22773 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288973AbSANT16>;
	Mon, 14 Jan 2002 14:27:58 -0500
Date: Mon, 14 Jan 2002 14:27:55 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: David Lang <david.lang@digitalinsight.com>
cc: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <Pine.LNX.4.40.0201141045130.22904-100000@dlang.diginsite.com>
Message-ID: <Pine.GSO.4.21.0201141419581.224-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jan 2002, David Lang wrote:

> I can see a couple reasons for building a kernel without useing modules.
> 
> 1. security, if you don't need any modules you can disable modules entirly
> and then it's impossible to add a module without patching the kernel first
> (the module load system calls aren't there)

Oh, please...  Give me permissions sufficient to make these syscalls
and in a couple of minutes your kernel will be replaced with ELIZA.
As a bonus - ELIZA running under TOPS-10 on PDP-10 emulator.  And talking
to PARRY.

Anyway, it's trivial to disable said system calls just before doing
execve("/sbin/init",...).  It won't buy you any security, but if you
insist...

> 2. speed, there was a discussion a few weeks ago pointing out that there
> is some overhead for useing modules (far calls need to be used just in
> case becouse the system can't know where the module will be located IIRC)

_That_ has to be addressed - regardless of anything else, if that suckitude
can be fixed it should be.

> 3. simplicity in building kernels for other machines. with a monolithic
> kernel you have one file to move (and a bootloader to run) with modules
> you have to move quite a few more files.

FVO"quite a few" equal to 2.  Kernel and initramfs.cpio.gz

