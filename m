Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261726AbTCGTV3>; Fri, 7 Mar 2003 14:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbTCGTV3>; Fri, 7 Mar 2003 14:21:29 -0500
Received: from hera.cwi.nl ([192.16.191.8]:52980 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261726AbTCGTV2>;
	Fri, 7 Mar 2003 14:21:28 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 7 Mar 2003 20:32:01 +0100 (MET)
Message-Id: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH] register_blkdev
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IMHO that's a bad change, (un)register_blkdev should just go away
> completly.

Yes, it would be best if the kernel became perfect at once.
But the patch is rather large. Better go in small steps.

Did you read the patch?

+/* Can be merged with blk_probe or deleted altogether. Later. */
+static struct blk_major_name {

Andries


[You often do general cleanup. My purpose is not to do
general cleanup, although this is a cleanup. My purpose
is to give us a 32-bit dev_t. After this patch the last
occurrence of MAX_BLKDEV is in raw.c. If Linus takes it,
the next patch will eliminate MAX_BLKDEV.]
