Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbUC2NIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUC2NII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:08:08 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24477
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262949AbUC2NF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 08:05:57 -0500
Date: Mon, 29 Mar 2004 15:05:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040329130554.GI3039@dualathlon.random>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <20040329042912.GI18054@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329042912.GI18054@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 08:29:12PM -0800, Wim Coekaerts wrote:
> > In 2.4 reaching 512k DMA units that helped a lot, but going past 512k
> > didn't help in my measurements.  1M maybe these days is needed (as Jens
> > suggested) but >1M still sounds overkill and I completely agree with
> > Jens about that.
> 
> at least 1Mb... more than 1mb (I doubt 32mb is really necessarily
> useful) is nice for flushing contiguous journal data to disk. between
> 1-8mb in one io.
> 
> at least 1mb is good when you have to process massive amounts of data,
> just read huge chunks of files, we tend to do 1mb. anyway,
> as you said, at some point it's a bit overkill . I thinkg 1-8mb makes
> sense. 

1M certainly it's reasonable, though for 8M I've my doubt you can
measure a throughput improvement, can you?
