Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267426AbTAGRAn>; Tue, 7 Jan 2003 12:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbTAGRAn>; Tue, 7 Jan 2003 12:00:43 -0500
Received: from [194.228.194.66] ([194.228.194.66]:61965 "HELO
	internetserver.planetarium.cz") by vger.kernel.org with SMTP
	id <S267426AbTAGRAh>; Tue, 7 Jan 2003 12:00:37 -0500
Message-ID: <3E1B0985.6050100@planetarium.cz>
Date: Tue, 07 Jan 2003 18:08:21 +0100
From: Michal Sojka <sojka@planetarium.cz>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Insmod failed
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'am porting driver for my USB 2.0 device to 2.5 and when I try insmod 
my module I get the following:

Error inserting '/lib/modules/2.5.54/misc/usb-emise.o': -1 Invalid 
module format


I compile my module separate of kernel tree with Makefile similar to 
that in Linux Device Drivers book (Rubini, Corbet). What is the right 
way to compile standalone modules?

module-init-tools version 0.9.7, kenrel 2.5.52,54

objdump -h /lib/modules/2.5.54/misc/usb-emise.o

/lib/modules/2.5.54/misc/usb-emise.o:     file format elf32-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
   0 .text         00001b94  00000000  00000000  00000034  2**2
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
   1 .data         000001c0  00000000  00000000  00001be0  2**5
                   CONTENTS, ALLOC, LOAD, RELOC, DATA
   2 .bss          00000000  00000000  00000000  00001da0  2**2
                   ALLOC
   3 .note         00000014  00000000  00000000  00001da0  2**0
                   CONTENTS, READONLY
   4 .stab         00007bd8  00000000  00000000  00001db4  2**2
                   CONTENTS, RELOC, READONLY, DEBUGGING
   5 .stabstr      0001893f  00000000  00000000  0000998c  2**0
                   CONTENTS, READONLY, DEBUGGING
   6 .rodata.str1.32 00000aa0  00000000  00000000  000222e0  2**5
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   7 .rodata.str1.1 00000129  00000000  00000000  00022d80  2**0
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
   8 __obsparm     00000080  00000000  00000000  00022ec0  2**5
                   CONTENTS, ALLOC, LOAD, DATA
   9 .rodata       00000004  00000000  00000000  00022f40  2**2
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
  10 .init.text    000000c8  00000000  00000000  00022f44  2**2
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  11 .exit.text    00000098  00000000  00000000  0002300c  2**2
                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  12 .comment      00000037  00000000  00000000  000230a4  2**0
                   CONTENTS, READONLY


Thanks
Michal Sojka

