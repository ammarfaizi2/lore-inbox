Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRF3AJk>; Fri, 29 Jun 2001 20:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264340AbRF3AJa>; Fri, 29 Jun 2001 20:09:30 -0400
Received: from ash.lnxi.com ([207.88.130.242]:5617 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S264327AbRF3AJT>;
	Fri, 29 Jun 2001 20:09:19 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Results of playing with linux-lite....
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 29 Jun 2001 18:09:03 -0600
Message-ID: <m3u20yrfq8.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I keep playing with different ideas on how to do the the minimal
bootloader seen, and wishing I had a full OS behind me todo it.

So today I played with linux-lite. A slightly modified linux-1.0.9.
It looks like you can get a pretty useable kernel out of it in about
128K, after compression.  

I have built up 2 patches
.eb1  This allows the code to compile with gcc-2.95.2 (hopefully the code works).
.eb2  This patch enables compiling out large sections of the kernel
      like the VFS layer, so I can experiment and see where the kernel
      bloat is.  I don't understand why the linux kernel when you disable
      everything is much larger than linuxBIOS.

The code is available at:
ftp://download.linuxnetworx.com/pub/src/linux-kernel-patches/

Even when I compile out the VFS layer, and the network stack, swap
support, and mmap, all character and block devices.  Uncompressed
the linux kernel is still about 100KB.  It feels like there is a
significant source of bloat there.  My hope is to build a very modular
kernel without nearly zero bloat and then port the infrastructure up
to the latest kernels.  Linux 1.0 is very much linux in structure, so
if nothing else it should be able to serve as a good comparision
point.

Anyway.  A kernel with nothing in it that compresses to 47KB is kind
of fun :)

Eric



