Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264834AbTBTWqo>; Thu, 20 Feb 2003 17:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265684AbTBTWqo>; Thu, 20 Feb 2003 17:46:44 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:21415 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S264834AbTBTWqm>; Thu, 20 Feb 2003 17:46:42 -0500
Message-Id: <5.1.0.14.2.20030220145240.0d449118@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 20 Feb 2003 14:56:22 -0800
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com, ak@suse.de, davem@redhat.com
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: ioctl32 consolidation
In-Reply-To: <20030220223119.GA18545@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:31 PM 2/20/2003, Pavel Machek wrote:
>Hi!
>
>Currently, 32-bit emulation in kernel has *5* copies, and its >1000
>lines each. Plus, locking of all but x86-64 architectures is broken
>(I'm told by andi ;-).
>
>So, here's patch that starts sharing sys32_ioctl() [as a first step],
>which should rmove locking problems.
>
>I've done the work for x86-64 and sparc64; if it looks good I'll
>attempt to do other architectures. [Unless maintainers prefer to do it
>themselves: I don't have easy access to 64-bit machines besides
>hammer.]

Nice. I'm glad that somebody started looking at this (I was going to work 
on that but didn't have time for it).
Patch looks ok to me.

Eventually we'll be able to kill ugly mess like arch/sparc64/kernel/ioctl32.c.
That stuff really belongs to the actual subsystems that implement those ioctls.

Thanks
Max

