Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263254AbRFEGwP>; Tue, 5 Jun 2001 02:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263264AbRFEGwG>; Tue, 5 Jun 2001 02:52:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12816 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263254AbRFEGvv>; Tue, 5 Jun 2001 02:51:51 -0400
Subject: Re: Missing cache flush.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 5 Jun 2001 07:49:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9fhqlj$7jt$1@penguin.transmeta.com> from "Linus Torvalds" at Jun 04, 2001 10:28:19 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157Aep-0006V7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - it is buggy and will lock up some CPU's. Use with EXTREME CAUTION.
>    Intel set a special field in the MP table for whether wbinval is
>    usable or not, and you can probably find their errata on which CPU's
>    it doesn't work on (I think it was some early PPro steppings).

Also some intel chipsets it didnt work with (notably earlier PCI ones) - indeed
that seems to be the cause of the 'bzImage wont boot on XYZ 486 tosh
laptop' bug.

> On the whole, I would suggest avoiding this like the plague, and just
> marking such memory to be non-cacheable, regardless of whether there is
> a performance impact or not. If you mark it write-combining and
> speculative, it's going to perform a bit better.

Or memcpy the blocks into the block or page cache when you need them. 

