Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293624AbSCAKdw>; Fri, 1 Mar 2002 05:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310422AbSCAKcH>; Fri, 1 Mar 2002 05:32:07 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:21779 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S310429AbSCAKbk>;
	Fri, 1 Mar 2002 05:31:40 -0500
Message-ID: <3C7F2B4D.71CD3C3B@yahoo.com>
Date: Fri, 01 Mar 2002 02:18:37 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.20 i586)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluesmoke/MCE support optional
In-Reply-To: <E16gaeU-0001di-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Is the MCE code big enough to justify this ? Last time I checked it was
> 1800 bytes 1000 of which were __init

Granted it isn't a huge monster (yet; size below) so use your own judgement;
I won't be upset either way.  I should note that a well respected developer
recently stated (on l-k) the following about making things unconditional:

	There are those of us trying to stuff Linux into embedded devices 
	who if anything want more configuration options not people taking 
	stuff out.

:-)

Same person went on to suggest:

	What I'd much rather see if this is an issue is:

	bool    'Do you want to customise for a very small system'

	which auto enables all the random small stuff if you say no, and goes
	much deeper into options if you say yes.

...an idea I like, but probably not appropriate for 2.4 - so perhaps I'll
work on a CONFIG_TINY for 2.5 if it is generally accepted as an ok plan.

Paul.
--
			bluesmoke.o:

Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         000001cb  00000000  00000000  00000040  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .data         00000004  00000000  00000000  0000020c  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
  2 .bss          00000008  00000000  00000000  00000210  2**2
                  ALLOC
  3 .note         00000014  00000000  00000000  00000210  2**0
                  CONTENTS, READONLY
  4 .data.init    0000000e  00000000  00000000  00000224  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  5 .rodata       000002d7  00000000  00000000  00000240  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .text.init    000001cd  00000000  00000000  00000520  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  7 .setup.init   00000010  00000000  00000000  000006f0  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
  8 .comment      00000026  00000000  00000000  00000700  2**0
                  CONTENTS, READONLY




