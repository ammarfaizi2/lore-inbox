Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVBHWas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVBHWas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVBHWas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:30:48 -0500
Received: from gprs215-154.eurotel.cz ([160.218.215.154]:60836 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261552AbVBHWal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:30:41 -0500
Date: Tue, 8 Feb 2005 23:27:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
Message-ID: <20050208222759.GB1347@elf.ucw.cz>
References: <20050207221107.GA1369@elf.ucw.cz> <20050207145100.6208b8b9.akpm@osdl.org> <20050208175106.GA1091@elf.ucw.cz> <20050208204300.GA18598@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208204300.GA18598@nevyn.them.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I wonder if reverting the patch will restore the old behaviour?
> > 
> > This seems to be minimal fix to get Kylix application back to the
> > working state... Maybe it is good idea for 2.6.11?
> 
> Why does clearing the BSS fail?  Are the program headers bogus?
> (readelf -l).

No idea, probably yes. Here's readelf -l result:

								Pavel

Elf file type is EXEC (Executable file)
Entry point 0x80614b4
There are 5 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  PHDR           0x000034 0x08048034 0x08048034 0x000a0 0x000a0 R E 0x4
  INTERP         0x0000d4 0x080480d4 0x080480d4 0x00013 0x00013 R   0x1
      [Requesting program interpreter: /lib/ld-linux.so.2]
  LOAD           0x000000 0x08048000 0x08048000 0xb7354 0x1b7354 R E 0x1000
  LOAD           0x0b7354 0x08200354 0x08200354 0x1e3e4 0x1f648 RW  0x1000
  DYNAMIC        0x0d56a0 0x0821e6a0 0x0821e6a0 0x00098 0x00098 RW  0x4

 Section to Segment mapping:
  Segment Sections...
   00     
   01     .interp 
   02     .interp .dynsym .dynstr .hash .rel.plt .plt .text borland.ressym borland.resstr borland.reshash borland.resdata borland.resspare 
   03     .data .rodata .got .dynamic .bss 
   04     .dynamic 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
