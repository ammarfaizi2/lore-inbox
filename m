Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132211AbQKXIk5>; Fri, 24 Nov 2000 03:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132308AbQKXIks>; Fri, 24 Nov 2000 03:40:48 -0500
Received: from Prins.externet.hu ([212.40.96.161]:32784 "EHLO
        prins.externet.hu") by vger.kernel.org with ESMTP
        id <S132211AbQKXIk3>; Fri, 24 Nov 2000 03:40:29 -0500
Date: Fri, 24 Nov 2000 09:10:22 +0100 (CET)
From: Boszormenyi Zoltan <zboszor@externet.hu>
To: linux-kernel@vger.kernel.org
Subject: Jens Axboe's blk-11 causing problems
Message-ID: <Pine.LNX.4.02.10011240902070.4804-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried 2.4.0-test11 (plain, +ac1/2) with and without
Jens' blk-11 patch. This indeed performs (much) better
when there is only high disk activity but cdrecord
starts up _very_ slowly if the kernel was compiled with 
blk-11. It does not happen if blk-11 is not applied.

I stopped cdrecord before it started writing because of
this suspicious slowness and I did not want to create a bad CD.

Other data points:
The CD-writer is a Yamaha-6416 (SCSI version).
The SCSI card is a Diamond Fireport-40 (Symbios 53c875j)
I tested both the in-kernel 1.6b and 1.7.2 versions of the
sym53c8xx driver.

The slowdown was experienced in every case where
the kernel contained blk-11.

Regards,
Zoltan Boszormenyi


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
