Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261930AbSJDO4O>; Fri, 4 Oct 2002 10:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261919AbSJDOyi>; Fri, 4 Oct 2002 10:54:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:58613 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261917AbSJDOyE>; Fri, 4 Oct 2002 10:54:04 -0400
Date: Fri, 4 Oct 2002 16:59:32 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-kernel@vger.kernel.org
Subject: Why does x86_64 support a SuSE-specific ioctl?
Message-ID: <Pine.NEB.4.44.0210041654570.11119-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

arch/x86_64/ia32/ia32_ioctl.c in both 2.4.20-pre8 and 2.5.40 contains:

<--  snip  -->

...
/* SuSE extension */
#ifndef TIOCGDEV
#define TIOCGDEV       _IOR('T',0x32, unsigned int)
#endif
static int tiocgdev(unsigned fd, unsigned cmd,  unsigned int *ptr)
{
...
}
...
HANDLE_IOCTL(TIOCGDEV, tiocgdev)
...

<--  snip  -->

TIOCGDEV is (as the comment above indicates) in neither 2.4.20-pre9 nor in
2.5.40 and I'm wondering why the x86_64 kernel supports a SuSE-specific
i386 ioctl?

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

