Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131665AbRDWJVu>; Mon, 23 Apr 2001 05:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRDWJVk>; Mon, 23 Apr 2001 05:21:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5636 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131630AbRDWJV1>; Mon, 23 Apr 2001 05:21:27 -0400
Subject: Re: MO drives (2048 byte block vfat fs) in lk 2.4
To: dougg@torque.net (Douglas Gilbert)
Date: Mon, 23 Apr 2001 10:22:25 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <3AE39A86.8AB3FB30@torque.net> from "Douglas Gilbert" at Apr 22, 2001 10:59:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rcY9-0007dP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The EIP resolved most often to cont_prepare_write() in
> fs/buffer. A disassembly suggests line 1802 in buffer.c
> [2.4.3ac11]. That is around a memset() between
> __block_prepare_write() and __block_commit_write() calls
> within the while loop. Most other addresses were within
> the same while loop. Perhaps someone with expertize
> in this area may like to examine that loop.

I'll take a dig. The fat code pulled out the magic buffer stuff because
it was meant to be going lower down which never happened..

Alan

