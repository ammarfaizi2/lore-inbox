Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSLMGsY>; Fri, 13 Dec 2002 01:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbSLMGsY>; Fri, 13 Dec 2002 01:48:24 -0500
Received: from smtp001.mail.tpe.yahoo.com ([202.1.238.48]:51216 "HELO
	smtp001.mail.tpe.yahoo.com") by vger.kernel.org with SMTP
	id <S261205AbSLMGsX>; Fri, 13 Dec 2002 01:48:23 -0500
Message-ID: <004d01c2a274$915cf690$3716a8c0@taipei.via.com.tw>
From: "Joseph" <jospehchan@yahoo.com.tw>
To: "Dave Jones" <davej@codemonkey.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0212111151410.1397-100000@twin.uoregon.edu> <002e01c2a1bf$4bfde0b0$3716a8c0@taipei.via.com.tw> <20021212133339.GE1145@suse.de>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Date: Fri, 13 Dec 2002 14:55:04 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>On Thu, Dec 12, 2002 at 05:17:29PM +0800, Joseph wrote:
>> Thanks for all response. :)
 >> I think I know more why it downgrades.
 >> But one more curious question.
 >> In the file, arch/i386/Makefile, under kernel 2.5.51.
 >> I found the C3 alignments , $(call check_gcc, -march=c3,-march=i486).
 >> Does the C3 CPU type be included in gcc compile option??
 >> I've downloaded the latest gcc 3.2.1 version.
 >> But I don't find the c3 options in the file gcc/config/i396/i386.c,
i386.h
 >> or etc.

>Not in a currently released gcc. CVS HEAD supports it, as will 3.3
>Dave

I've checked the gcc CVS. But it seems to use i486 pluse MMX and 3DNOW
instructions.
* config.gcc: Treat winchip_c6-*|winchip2-*|c3-* as pentium-mmx.
* config/i386/i386.c (processor_alias_table): Add winchip-c6, winchip2 and
c3.
* doc/invoke.texi: Mention new aliases.
**  {"c3", PROCESSOR_I486, PTA_MMX | PTA_3DNOW},   **
Is there any plan to optimize for C3 CPU in future gcc released version?
BR,
  Joseph

-----------------------------------------------------------------
< ¨C¤Ñ³£ Yahoo!©_¼¯ >  www.yahoo.com.tw
