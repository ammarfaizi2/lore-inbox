Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKVA6L>; Tue, 21 Nov 2000 19:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131031AbQKVA6C>; Tue, 21 Nov 2000 19:58:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30039 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129150AbQKVA5x>; Tue, 21 Nov 2000 19:57:53 -0500
Subject: Re: e2fs performance as function of block size
To: jmerkey@timpanogas.org (Jeff V. Merkey)
Date: Wed, 22 Nov 2000 00:27:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), cma@mclink.it (CMA), tytso@mit.edu,
        card@masi.ibp.fr, linux-kernel@vger.kernel.org
In-Reply-To: <3A1B0DFC.72E4E9FF@timpanogas.org> from "Jeff V. Merkey" at Nov 21, 2000 05:06:20 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yNlM-0005Q3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's as though the disk drivers are optimized for this case (1024).  I

The disk drivers are not, and they normally see merged runs of blocks so they
will see big chunks rather than 1K then 1K then 1K etc.

> behavior, but there is clearly some optimization relative to this size
> inherent in the design of Linux -- and it may be a pure accident.  This
> person may be mixing and matching block sizes in the buffer cache, which
> would satisfy your explanation.

I see higher performance with 4K block sizes. I should see higher latency too
but have never been able to measure it. Maybe it depends on the file system.
It certainly depends on the nature of requests


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
