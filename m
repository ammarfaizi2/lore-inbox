Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270572AbRHITqr>; Thu, 9 Aug 2001 15:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270571AbRHITqh>; Thu, 9 Aug 2001 15:46:37 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:53515 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S270568AbRHITqb>; Thu, 9 Aug 2001 15:46:31 -0400
Message-ID: <3B72E9FA.883833D8@zip.com.au>
Date: Thu, 09 Aug 2001 12:52:26 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: FYI (2.4.4) on a HP Netserver LD Pro
In-Reply-To: <3B728283.10458.105A5C8@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl wrote:
> 
> Hello,
> 
> I have some odd boot messages (new since switching from kernel 2.2 to
> 2.4) for the HP Netserver LD Pro (Pentium Pro 200MHz). I'd like to know
> if there is a hardware or configuration problem, or whether it's "just
> normal" (the "reserved twice").
> 
> Messages:
> <4>Linux version 2.4.4-4GB (root@Pentium.suse.de) (gcc version 2.95.3
> 20010315 \
> (SuSE)) #1 Wed May 16 00:37:55 GMT 2001
> <6>BIOS-provided physical RAM map:
> <4> BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
> <4> BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
> <4> BIOS-e820: 00000000000f1cb4 - 0000000000100000 (reserved)
> <4> BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
> <4> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
> <4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> <4> BIOS-e820: 00000000ffff1cb4 - 0000000100000000 (reserved)
> <4>Scan SMP from c0000000 for 1024 bytes.
> <4>Scan SMP from c009fc00 for 1024 bytes.
> <4>Scan SMP from c00f0000 for 65536 bytes.
> <4>found SMP MP-table at 000fd8d0
> <4>hm, page 000fd000 reserved twice.
> <4>hm, page 000fe000 reserved twice.
> <4>hm, page 0009e000 reserved twice.
> <4>hm, page 0009f000 reserved twice.

It's "just normal".  The MP-table parsing code reserves space
for the MP table and then parses the table.  But the table
also reserves its own space.

-
