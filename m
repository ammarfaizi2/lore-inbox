Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbUC2EaY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 23:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbUC2EaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 23:30:24 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:12483 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S262618AbUC2EaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 23:30:22 -0500
Date: Sun, 28 Mar 2004 20:29:12 -0800
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040329042912.GI18054@ca-server1.us.oracle.com>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329005502.GG3039@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In 2.4 reaching 512k DMA units that helped a lot, but going past 512k
> didn't help in my measurements.  1M maybe these days is needed (as Jens
> suggested) but >1M still sounds overkill and I completely agree with
> Jens about that.

at least 1Mb... more than 1mb (I doubt 32mb is really necessarily
useful) is nice for flushing contiguous journal data to disk. between
1-8mb in one io.

at least 1mb is good when you have to process massive amounts of data,
just read huge chunks of files, we tend to do 1mb. anyway,
as you said, at some point it's a bit overkill . I thinkg 1-8mb makes
sense. 

