Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbRF0Sxg>; Wed, 27 Jun 2001 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265370AbRF0SxZ>; Wed, 27 Jun 2001 14:53:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44037 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265369AbRF0SxG>; Wed, 27 Jun 2001 14:53:06 -0400
Subject: Re: Allocating non-contigious memory
To: galibert@pobox.com (Olivier Galibert)
Date: Wed, 27 Jun 2001 19:52:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Hack inc .)
In-Reply-To: <20010627144239.A2265@zalem.puupuu.org> from "Olivier Galibert" at Jun 27, 2001 02:42:39 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FKQh-0005ef-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the Right Way[tm] as of 2.4.6 to allocate 16Mb as 4K pages and
> get the pci bus address for each page?  Bonus points is they're
> virtually contiguous, but that's not necessary.  IIRC, the old
> vmalloc-then-walk-the-pagetables trick is considered out-of-bounds
> nowadays.

If you want it virtually contiguous then copy the code from bttv that 
out-of-bounds or otherwise is now found in about 8 drivers in the kernel.

If you don't need that then you can map user space and use kiovecs - which
is nicer for many things

