Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbULQT7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbULQT7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbULQT7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:59:10 -0500
Received: from vsmtp2alice.tin.it ([212.216.176.142]:12796 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S262146AbULQT7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:59:03 -0500
Subject: x86_64 2.6.x problem
From: Luca <luca.marrazzo@gmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 17 Dec 2004 20:59:04 +0100
Message-Id: <1103313544.10508.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
I have a "private" static binary that works on 32bit system and
on a 2.4.x kernel 64bit system.
With the 2.6.x kernel 64bit it doesn't work.
Here some output:

Processor 3400+ AuthenticAMD
Kernel 2.6.9
gentoo 2004.3


$ file client
client: ELF invalid class invalid byte order (SYSV)

$ ./client
Segmentation fault

on /var/log/messages

client[10543]: segfault at 0000000000000000 rip 000000005dea4119 rsp
00000000ffffd6f0 error 6

$ readelf -a client
ELF Header:
  Magic:   7f 45 4c 46 00 00 00 00 00 00 00 00 00 00 00 00
  Class:                             none
  Data:                              none
  Version:                           0
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           Intel 80386
  Version:                           0x1
  Entry point address:               0x5dea40de
  Start of program headers:          52 (bytes into file)
  Start of section headers:          0 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         1
  Size of section headers:           0 (bytes)
  Number of section headers:         0
  Section header string table index: 0

There are no sections in this file.

There are no section groups in this file.

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg
Align
  LOAD           0x000000 0x5dea4000 0x5dea4000 0x075ce 0x1d000 RWE
0x1000

There is no dynamic section in this file.

There are no relocations in this file.

There are no unwind sections in this file.

No version information found in this file.

if you can tell me what do i have to do,
bye

Luca

P.S.
I'm not subscribed to the list so please CC to me :)



