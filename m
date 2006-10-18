Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWJRLEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWJRLEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 07:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWJRLEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 07:04:05 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:19633 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030198AbWJRLEC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 07:04:02 -0400
Message-ID: <45360952.5020307@aitel.hist.no>
Date: Wed, 18 Oct 2006 13:00:34 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Jakob Oestergaard <jakob@unthought.net>,
       Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com> <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <20061018095125.GE24452@kernel.dk>
In-Reply-To: <20061018095125.GE24452@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> While that may make some sense internally, the exported interface would
> never be workable like that. It needs to be simple, "give me foo kb/sec
> with max latency bar for this file", with an access pattern or assumed
> sequential io.
>
> Nobody speaks of iops/sec except some silly benchmark programs. I know
> that you are describing pseudo-iops, but it still doesn't make it more
> clear.
> Things aren't as simple
>   
How about "give me 10% of total io capacity?"  People understand
this, and the io scheduler can then guarantee this by ensuring
that the process gets 1 out of 10 io requests as long as it
keeps submitting enough.

The admin can then set a reasonable percentage depending on
the machine's capacity.

Helge Hafting
