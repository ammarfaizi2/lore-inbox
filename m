Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271591AbRHPRBR>; Thu, 16 Aug 2001 13:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271593AbRHPRBG>; Thu, 16 Aug 2001 13:01:06 -0400
Received: from bgm-24-95-140-16.stny.rr.com ([24.95.140.16]:55030 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S271591AbRHPRAy>; Thu, 16 Aug 2001 13:00:54 -0400
Date: Thu, 16 Aug 2001 13:05:42 -0400 (EDT)
From: Steven Rostedt <rostedt@stny.rr.com>
X-X-Sender: <rostedt@localhost.localdomain>
Reply-To: Steven Rostedt <srostedt@stny.rr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: gcc 3.0 Warnings
Message-ID: <Pine.LNX.4.33.0108161147560.12810-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The work I do for my company requires modifying the kernel.
I now use gcc 3.0 with warnings as errors (-Werror). Every time I get a
new kernel, I need to fix include/asm/checksum.h for i386 and arm, I don't
know about the other architectures since I have only used 3.0 on these
two.

The problem is that I now get the warning:

"warning: multi-line string literals are deprecated"

which is due to the inline assembly that uses strings that don't end on a
single line and causes my compile to end there. Now I know that this is just
my problem, since I changed the KERNEL_CFLAGS to be -Werror, but wouldn't
it be cleaner to have no warnings with the new compiler?

I don't know if this has been brought up before, but I'm willing to clean
up the latest version of the kernel so that these warnings go away. But
I've never submitted a kernel patch before, and I'm only willing to do
this to the clean kernel if it will be accepted. The only changes I would
make would be to clean up the warnings that gcc 3.0 gives.

Is this worth the effort? What do you think.

-- Steven Rostedt

