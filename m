Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278660AbRLIAsp>; Sat, 8 Dec 2001 19:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRLIAsf>; Sat, 8 Dec 2001 19:48:35 -0500
Received: from mailrelay.netcologne.de ([194.8.194.96]:42372 "EHLO
	mailrelay.netcologne.de") by vger.kernel.org with ESMTP
	id <S277228AbRLIAsU>; Sat, 8 Dec 2001 19:48:20 -0500
Message-ID: <009a01c1804b$31621aa0$30d8fea9@ecce>
From: "[MOc]cda*mirabilos" <mirabilos@netcologne.de>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <200112090039.BAA25399@webserver.ithnet.com>
Subject: Re: Typedefs / gcc / HIGHMEM
Date: Sun, 9 Dec 2001 00:48:17 -0000
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

> Ha, I always wondered what this u64 is all about :-)
> Honestly, this whole datatyping is gone completely mad since the 16-32
> bit  change. In my opinion
> byte is 8 bit
> short is 16 bit
> long is 32 bit
> <callwhatyouwant> is 64 bit (I propose long2 for expression of bitsize
> long * 2).
> <callwhatyouwant2> is 128 bit (Ha, right I would call it long4)

There's the bit types:
u_int8_t (unsigned char)
u_int16_t (unsigned short int)
...

int8_t (signed char)
int16_t (signed short int)
...

size_t and register_t
If I understand these correctly, size_t is the size of a pointer
(ptrdiff_t on linux?) and register_t is signed size_t.

These are common along GNU and BSD systems,
just #ifdef __BIT_TYPES_DEFINED__
For porting issues, many Win32 headers have them as now,
and for DOS16 and DOS32 they're easy.

> char is the standard representation of chars in the corresponding
> environment, currently sizeof(byte).
> int is the same and should move from 16 bit to 32 bit to 64 bit
> depending on the machine. I mean whats the use of an int register in a
> 64bit environment, when datatype int is only of size 32 bit? This is
> _shit_.

ACK.

-mirabilos


