Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUAKWD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUAKWD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:03:27 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:24249 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S265955AbUAKWD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:03:26 -0500
To: Valdis.Kletnieks@vt.edu
Cc: Job 317 <job317@mailvault.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: HELP!! 2.6.x build problem with make xconfig
References: <20040110235440.7962B8400A3@gateway.mailvault.com>
	<200401110019.i0B0J2Ld014059@turing-police.cc.vt.edu>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 11 Jan 2004 21:40:05 +0100
In-Reply-To: <200401110019.i0B0J2Ld014059@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Sat, 10 Jan 2004 19:19:02 -0500")
Message-ID: <m33camdxsq.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

>> cd /usr/include
>> rm asm linux scsi
>> ln -fs /usr/src/linux/include/asm-i386 asm
>> ln -fs /usr/src/linux/include/linux linux
>> ln -fs /usr/src/linux/include/scsi scsi
>
> Don't do that.
>
> Use what's in the glibc-kernheaders RPM for userspace, and let the kernel
> provide its own headers for its use.

GNU libc doesn't have (nor need) its own "kernel" headers and uses the
kernel ones.
You may live with "glibc-kernheaders" package only if it matches your
system. If you're using a different (newer, modified etc) kernel then
you need the symlinks or a copy (example: new ioctls + programs using
them).

You may need to recompile the libc as well, if the libc-kernel (binary)
interface has changed.
-- 
Krzysztof Halasa, B*FH
