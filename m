Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbUC2IQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUC2IOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:14:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59278 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262756AbUC2INs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:13:48 -0500
Date: Mon, 29 Mar 2004 10:13:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040329081320.GS24370@suse.de>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <20040329042912.GI18054@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329042912.GI18054@ca-server1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 2004, Wim Coekaerts wrote:
> > In 2.4 reaching 512k DMA units that helped a lot, but going past 512k
> > didn't help in my measurements.  1M maybe these days is needed (as Jens
> > suggested) but >1M still sounds overkill and I completely agree with
> > Jens about that.
> 
> at least 1Mb... more than 1mb (I doubt 32mb is really necessarily
> useful) is nice for flushing contiguous journal data to disk. between
> 1-8mb in one io.

'is nice' means what, in real numbers? :)

> at least 1mb is good when you have to process massive amounts of data,
> just read huge chunks of files, we tend to do 1mb. anyway,
> as you said, at some point it's a bit overkill . I thinkg 1-8mb makes
> sense. 

Yeah, that _range_ makes sense. 1MB is a lot more supportable than 8MB
though, so the benefit needs to be something more than a feel good
sensation.

-- 
Jens Axboe

