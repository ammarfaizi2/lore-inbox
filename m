Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265116AbUASSv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUASSv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:51:57 -0500
Received: from mail3-126.ewetel.de ([212.6.122.126]:19364 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S265116AbUASSvz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:51:55 -0500
Date: Mon, 19 Jan 2004 19:51:37 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Andries.Brouwer@cwi.nl, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix for ide-scsi crash
Message-ID: <Pine.LNX.4.44.0401191945560.976-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A rather reproducible crash with ide-scsi that I reported
> yesterday is fixed by the patch below.

> [With this in place I wrote three times 640 MB to floptical and diffed;
> no problems occurred. Without it the system would crash each time.]

I can confirm that it also makes my MO drive work with ide-scsi.
I could also successfully write 4.1 GB of data to a DVD+RW disc.
Writing 700 MB to a normal CD-RW disc also worked (yes, I know I
could use ide-cd for this, I just did this for testing the ide-scsi
fix).

This patch seems to solve all my 2.6 ide-scsi problems.

Andrew, you can drop the atapi-mo-support patches from -mm if you
like. That patch only works with 2048 byte sector discs, while
the ide-scsi/sd solution also works with 512 and 1024 byte sector
discs.

-- 
Ciao,
Pascal

