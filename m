Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUC3RsD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUC3Rra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:47:30 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:27155 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263778AbUC3Rqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:46:44 -0500
Message-ID: <4069B6F8.1020506@techsource.com>
Date: Tue, 30 Mar 2004 13:05:44 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jeff Garzik <jgarzik@pobox.com>, Andrea Arcangeli <andrea@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com> <20040329130410.GH3039@dualathlon.random> <40687CF0.3040206@pobox.com> <20040330110928.GR24370@suse.de>
In-Reply-To: <20040330110928.GR24370@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Axboe wrote:

> - The optimal_sectors calculation is just an average of previous maximum
>   with current maximum. The scheme has a number of break down points,
>   for instance writes starving reads will give you a bad read execution
>   time, further limiting ->optimal_sectors[READ]


I did look through your code a bit, but one thing to be concerned with 
is that going only on max throughput might be fooled by cache hits on 
the drive.

