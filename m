Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbUBYI5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 03:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbUBYI5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 03:57:37 -0500
Received: from main.gmane.org ([80.91.224.249]:42711 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262497AbUBYI4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 03:56:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Why are 2.6 modules so huge?
Date: Wed, 25 Feb 2004 09:56:41 +0100
Message-ID: <yw1xd683fsfq.fsf@kth.se>
References: <9cfptc4lckg.fsf@rogue.ncsl.nist.gov> <yw1x1xokcwfo.fsf@kth.se>
 <403C4E98.6010107@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:IEaa/8tiwkxDi+EJSlr+JxHe4zA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel <harald.dunkel@t-online.de> writes:

> Måns Rullgård wrote:
>> My 2.6.3 vfat.ko is 15365 bytes.  Maybe you enabled kernel debugging
>> symbols.
>>
>
> % ll /lib/modules/2.6.3/kernel/fs/vfat/
> total 16
> -rw-r--r--    1 root     root        14232 Feb 19 07:43 vfat.ko
>
> Assuming that you are on i686:
>
> A size difference of 1 KByte (about 7%) is remarkable. Which
> gcc did you use for building 2.6.3?

I used gcc 3.3.2.  Here's an objdump -h of that file:

/lib/modules/2.6.3/kernel/fs/vfat/vfat.ko:     file format elf32-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         0000209c  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .init.text    00000013  00000000  00000000  000020d0  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  2 .exit.text    00000013  00000000  00000000  000020e3  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  3 .rodata.str1.1 0000004c  00000000  00000000  000020f6  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .rodata.str1.32 00000073  00000000  00000000  00002160  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 __ksymtab_strings 00000046  00000000  00000000  000021d3  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 __ksymtab     00000030  00000000  00000000  0000221c  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  7 .modinfo      00000059  00000000  00000000  00002260  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  8 .data         00000120  00000000  00000000  000022c0  2**5
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
  9 .gnu.linkonce.this_module 00000200  00000000  00000000  00002400  2**7
                  CONTENTS, ALLOC, LOAD, RELOC, DATA, LINK_ONCE_DISCARD
 10 .bss          00000000  00000000  00000000  00002600  2**2
                  ALLOC
 11 .comment      00000036  00000000  00000000  00002600  2**0
                  CONTENTS, READONLY


-- 
Måns Rullgård
mru@kth.se

