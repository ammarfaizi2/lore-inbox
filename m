Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280387AbRKNJyO>; Wed, 14 Nov 2001 04:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280395AbRKNJxz>; Wed, 14 Nov 2001 04:53:55 -0500
Received: from [195.63.194.11] ([195.63.194.11]:42505 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280394AbRKNJxq>; Wed, 14 Nov 2001 04:53:46 -0500
Message-ID: <3BF23D01.F7E879E8@evision-ventures.com>
Date: Wed, 14 Nov 2001 10:44:33 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
In-Reply-To: <200111131851.fADIpTN20263@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
> 
> Let me put it more plainly.  Martin Daleki + rumour assures me that the
> blk_size array nowadays measure in blocks not KB, yet to me it seems that

sectors = 512 per default
blocks = 1024 per default.


Never said anything else.

Look at the initialization point for the arrays. They all use constants
which you can look up in the kernel headers.

./linux/fs.h:#define BLOCK_SIZE_BITS 10
./linux/fs.h:#define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)

Which means 1024 bytes for blk_size as default value.

> it doesn't.  Look at this code from ll_rw_blk.c in 2.4.13:


-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
