Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWCTKMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWCTKMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 05:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWCTKMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 05:12:08 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:31678 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751114AbWCTKMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 05:12:07 -0500
Message-ID: <06f301c64c06$b820f440$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: <linux-kernel@vger.kernel.org>, <ext2-devel@lists.sourceforge.net>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp> <20060319022002.GA19607@thunk.org>
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Date: Mon, 20 Mar 2006 19:11:51 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I've just checked my i386 assembly language reference, and I don't see
> any indication that the btsl, btrl, and btl instructions don't work if
> the high bit is set on the bit number.  Have you done tests showing
> that these instructions do not work correctly for filesystem sizes >
> 2**31 blocks, 

Of course I did and confirmed to get the segmentation fault
at those instructions.

>                          or have references showing that these instructions
> interpret the bit number as a signed integer?

I got the developer's manual from the following site.
ftp://download.intel.com/design/Pentium4/manuals/25366618.pdf
There is the description of "See also: Bit(BitBase, BitOffset) on page 3-10"
on the explanation of "bts" at page 3-82.

"Table 3-2. Range of Bit Positions Specified by Bit Offset Operands"
 at page 3-10 says that the register bit offset is restricted
from -2^31 to 2^31 - 1.

--
Takashi Sato 
