Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284800AbRLPUhx>; Sun, 16 Dec 2001 15:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284809AbRLPUhn>; Sun, 16 Dec 2001 15:37:43 -0500
Received: from relay03.cablecom.net ([62.2.33.103]:41501 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S284800AbRLPUhd>; Sun, 16 Dec 2001 15:37:33 -0500
Message-ID: <3C1D060B.9475C9F8@bluewin.ch>
Date: Sun, 16 Dec 2001 21:37:32 +0100
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Booting a modular kernel through a multiple streams file
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I don't think a kernel without anything compiled in is currently functional
but I'd rather like to have as less as possible. And I _don't_ like the solution
with initrd. So I've thought about other solutions to solve the hen-egg dilemma
when booting a modular kernel.

Well a simple solution would be if Linux supports the multiple streams file
format. Assume the kernel and all necessary modules for booting (if not all
modules) are combined into a single file. The boot loader (i.e. lilo) simply
loads this file and starts the first stream (the kernel). It doesn't need to
know the full multiple stream format (maybe nothing at all). The kernel of
course needs this functionality to load the rest of the modules for a minimal
working system. 

I assume it's no problem to integrate the building of this boot file into either
the Linux compilation or better into a separate setup phase (possibly together
with good hardware/module detection).

Advantages:
- A simple boot loader can handle it without much tweaking
- The multiple streams file format is a standard concept usable anywhere
- No ramdisk is necessary
- This concept needs possibly less kernel functionality than initrd
- No change in the current compilation process except for the additional setup phase

Disadvantages:
- Someone else has to do it, I'm not a kernel/driver developer

Why did nobody else have this simple idea? I don't know, maybe the multiple
streams file format isn't widely known in the Linux community. Who else does use
it? The MacOS runs nicely with it, supporting data and resource streams. Maybe
it is already ported from the MacOS X to Darwin. WindowsNT supports it but
doesn't use it.

O. Wyss
