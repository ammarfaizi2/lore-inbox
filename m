Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131069AbRBXBHB>; Fri, 23 Feb 2001 20:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131065AbRBXBGv>; Fri, 23 Feb 2001 20:06:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63758 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131069AbRBXBGl>; Fri, 23 Feb 2001 20:06:41 -0500
Subject: Re: RFC: vmalloc improvements
To: baettig@scs.ch
Date: Sat, 24 Feb 2001 01:09:28 +0000 (GMT)
Cc: linux-mm@kvack.org (MM Linux), linux-kernel@vger.kernel.org (Kernel Linux),
        frey@scs.ch (Martin Frey)
In-Reply-To: <200102240026.QAA09446@k2.llnl.gov> from "Reto Baettig" at Feb 23, 2001 04:26:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14WTDH-0007UQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have an application that makes extensive use of vmalloc (we need
> lots of large virtual contiguous buffers. The buffers don't have to be
> physically contiguous).

So you could actually code around that. If you have them virtually contiguous
for mmap for example then you can actually mmap arbitary page arrays

> We would volounteer to improve vmalloc if there is any chance of
> getting it into the main kernel tree. We also have an idea how we
> Could do that (quite similar to the process address space management):

Im not the one to call the shots, but it seems if you need an AVL for the
vmalloc tables then vmalloc is possibly being overused, or people are not
allocating buffers just occasionally as anticipated
