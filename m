Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282124AbRK1Ktk>; Wed, 28 Nov 2001 05:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282117AbRK1Kta>; Wed, 28 Nov 2001 05:49:30 -0500
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:17558 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S282123AbRK1KtS>;
	Wed, 28 Nov 2001 05:49:18 -0500
Message-ID: <000701c177fa$36872380$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.16 Compiler warning
Date: Wed, 28 Nov 2001 05:48:28 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This appears to be a non-fatal warning....does this need to be cleaned up?
gcc 2.95.3

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-tri
graphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fn
o-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o pci-pc.o
pci-pc.c
{standard input}: Assembler messages:
{standard input}:1107: Warning: indirect lcall without `*'
{standard input}:1192: Warning: indirect lcall without `*'
{standard input}:1279: Warning: indirect lcall without `*'
{standard input}:1361: Warning: indirect lcall without `*'
{standard input}:1372: Warning: indirect lcall without `*'
{standard input}:1383: Warning: indirect lcall without `*'
{standard input}:1470: Warning: indirect lcall without `*'
{standard input}:1482: Warning: indirect lcall without `*'
{standard input}:1494: Warning: indirect lcall without `*'
{standard input}:1975: Warning: indirect lcall without `*'
{standard input}:2068: Warning: indirect lcall without `*'

Here's all the lcall's in pci-pc.c:
        __asm__("lcall (%%edi); cld"
                        "lcall (%%edi); cld\n\t"
        __asm__("lcall (%%edi); cld\n\t"
                __asm__("lcall (%%esi); cld\n\t"
                __asm__("lcall (%%esi); cld\n\t"
                __asm__("lcall (%%esi); cld\n\t"
                __asm__("lcall (%%esi); cld\n\t"
                __asm__("lcall (%%esi); cld\n\t"
                __asm__("lcall (%%esi); cld\n\t"
                "lcall (%%esi); cld\n\t"
        __asm__("lcall (%%esi); cld\n\t"


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

