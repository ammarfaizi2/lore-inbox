Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbUCFVFi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 16:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbUCFVFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 16:05:38 -0500
Received: from hermes.dur.ac.uk ([129.234.4.9]:22488 "EHLO hermes.dur.ac.uk")
	by vger.kernel.org with ESMTP id S261713AbUCFVFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 16:05:33 -0500
Subject: Re: Potential bug in fs/binfmt_elf.c?
From: Mike Hearn <mike@navi.cx>
Reply-To: mike@navi.cx
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <404A1C71.3010507@redhat.com>
References: <1078508281.3065.33.camel@linux.littlegreen>
	 <404A1C71.3010507@redhat.com>
Content-Type: text/plain
Message-Id: <1078607410.10313.7.camel@linux.littlegreen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 06 Mar 2004 21:10:11 +0000
Content-Transfer-Encoding: 7bit
X-DurhamAcUk-MailScanner: Found to be clean, Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-06 at 18:46, Ulrich Drepper wrote:
> Show an example of what the file looks like.  Just the ELF program
> header (readelf -l output).

I can send the linker script and source file on request. They are
probably a bit buggy, this isn't an area I know much about. The binutils
guys seemed to think it should work however.

thanks -mike


Elf file type is EXEC (Executable file)
Entry point 0x818
There are 6 program headers, starting at offset 52
 
Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  PHDR           0x000034 0x00000034 0x00000034 0x000c0 0x000c0 R   0x4
  INTERP         0x000400 0x00000400 0x00000400 0x00034 0x00034 R   0x4
      [Requesting program interpreter: /lib/ld-linux.so.2]
  LOAD           0x000000 0x00000000 0x00000000 0x00bc4 0x00bc4 R E 0x1000
  LOAD           0x000bc4 0x00000bc4 0x00000bc4 0x00150 0x00154 RW  0x1000
  DYNAMIC        0x000bd0 0x00000bd0 0x00000bd0 0x00108 0x00108 RW  0x4
  LOAD           0x001000 0x00400000 0x00400000 0x00000 0x10000000 R   0x1000
 
 Section to Segment mapping:
  Segment Sections...
   00
   01     .interp .note.ABI-tag
   02     .interp .note.ABI-tag .hash .dynsym .dynstr .gnu.version .gnu.version_r .rel.dyn .rel.plt .init .plt .text .fini .rodata .eh_frame
   03     .data .dynamic .ctors .dtors .jcr .got .bss
   04     .dynamic
   05     .wine.loadarea


