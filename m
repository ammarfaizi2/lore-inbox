Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278639AbRJXQFy>; Wed, 24 Oct 2001 12:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278636AbRJXQFo>; Wed, 24 Oct 2001 12:05:44 -0400
Received: from python.uk.inktomi.com ([212.62.9.218]:14745 "EHLO
	python.inktomi.co.uk") by vger.kernel.org with ESMTP
	id <S278633AbRJXQFd>; Wed, 24 Oct 2001 12:05:33 -0400
Reply-To: <colinj@inktomi.com>
From: "Colin Johnston" <colinj@inktomi.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel bug in 2.2.16 ?? 
Date: Wed, 24 Oct 2001 17:01:08 +0100
Message-ID: <KFEJLJDLCMOJNFOGFMFNGENKELAA.colinj@inktomi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Anyone have any clues as the oops below, bigmem patch applied as well.
causes a hang of pc and oops info in console. decoded info below

DEBUG (Oops_decode): /tmp/ksymoops.jIvkke:     file format elf32-i386
DEBUG (Oops_decode): architecture: i386, flags 0x00000010:
DEBUG (Oops_decode): HAS_SYMS
DEBUG (Oops_decode): start address 0x00000000
DEBUG (Oops_decode):
DEBUG (Oops_decode): Sections:
DEBUG (Oops_decode): Idx Name          Size      VMA       LMA       File
off  Algn
DEBUG (Oops_decode):   0 .text         00000040  00000000  00000000
00000040  2**4
DEBUG (Oops_decode):                   CONTENTS, ALLOC, LOAD, READONLY, CODE
DEBUG (Oops_decode): Disassembly of section .text:
DEBUG (Oops_decode):
DEBUG (Oops_decode): 00000000 <_XXX>:
DEBUG (Oops_decode):    0:   8b 4e 08                  mov    0x8(%esi),%ecx
DEBUG (Oops_decode):    3:   83 f9 ff                  cmp
$0xffffffff,%ecx
DEBUG (Oops_decode):    6:   0f 84 a7 00 00 00         je     b3 <_XXX+0xb3>
DEBUG (Oops_decode):    c:   89 c8                     mov    %ecx,%eax
DEBUG (Oops_decode):    e:   25 ff 01 00 00            and    $0x1ff,%eax
DEBUG (Oops_decode):   13:   8b 00                     mov    (%eax),%eax
DEBUG (Oops_decode):         ...
DEBUG (Oops_format):

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 4e 08                  mov    0x8(%esi),%ecx
Code;  00000003 Before first symbol
   3:   83 f9 ff                  cmp    $0xffffffff,%ecx
Code;  00000006 Before first symbol
   6:   0f 84 a7 00 00 00         je     b3 <_EIP+0xb3> 000000b3 Before
first symbol
Code;  0000000c Before first symbol
   c:   89 c8                     mov    %ecx,%eax
Code;  0000000e Before first symbol
   e:   25 ff 01 00 00            and    $0x1ff,%eax
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!

Colin Johnston
Inktomi Support Engineer
phone work: +44 207 4305813
mobile phone work: +44 7796 308167
email: colinj@inktomi.com

