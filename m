Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264995AbSJWNlZ>; Wed, 23 Oct 2002 09:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264996AbSJWNlZ>; Wed, 23 Oct 2002 09:41:25 -0400
Received: from srv1.mail.cv.net ([167.206.112.40]:59813 "EHLO srv1.mail.cv.net")
	by vger.kernel.org with ESMTP id <S264995AbSJWNlX>;
	Wed, 23 Oct 2002 09:41:23 -0400
Date: Wed, 23 Oct 2002 09:47:27 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
Subject: "Hearty AOL" for kexec
X-X-Sender: proski@localhost.localdomain
To: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Message-id: <Pine.LNX.4.44.0210230926320.9286-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have tested the latest kexec patch (linux-2.5.44.x86kexec.diff) with
the kernel 2.5.44.  It works for me on AOpen AK-33 motherboard with 1GHz
Athlon.  I tried the same kernel and 2.4.20-pre10.

I really want to see this feature in the kernel.  It is very useful in
embedded systems.  Just imagine loading the bootstrap kernel, then
downloading the new kernel over anything - HDLC, 802.11, USB, decrypting
it from flash etc.  Possibilities are infinite.

Believe me, this code is needed, and there will be kernel hackers using
it, so if anything needs fixing, it will be fixed by people who know to
fix it.  It will be more an asset than a responsibility for the kernel
maintainers.

That said, I don't like the name kexec, and especially the work "execing" 
in arch/i386/config.in.  I think "in-kernel bootloader" or something like 
that would be better.  It is a reboot after all.

Little fix: there is no need to add kexec.o twice to obj-$(CONFIG_KEXEC)
in kernel/Makefile - it causes rebuilding kexec.o on every make.  One time 
is enough.

Little bug (missing feature): I cannot execute memtest.bin 
(http://www.memtest86.com/):

./kexec /boot/memtest.bin
read error: Success
Cannot determine the file type of /boot/memtest.bin

I'm using kexec-tools-1.2.  The rest of the system is Red Hat 8.0.

-- 
Regards,
Pavel Roskin

