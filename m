Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261728AbSI0OwB>; Fri, 27 Sep 2002 10:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261722AbSI0OwA>; Fri, 27 Sep 2002 10:52:00 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:57551 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261714AbSI0Ov7>; Fri, 27 Sep 2002 10:51:59 -0400
Date: Fri, 27 Sep 2002 11:56:49 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Jens Axboe <axboe@suse.de>, Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Warning - running *really* short on DMA buffers while doing file
 transfers
In-Reply-To: <389902704.1033133455@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.44L.0209271155510.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002, Justin T. Gibbs wrote:

> writes *unless* you are creating an ISO image on your disk.  In my opinion
> it is much more important to optimize for the more common, concurrent
> read case, than it is for the sequential write case with intermittent
> reads.

You're missing the point.  The only reason the reads are
intermittent is that the application can't proceed until
the read is done and the read is being starved by writes.

If the read was serviced immediately, the next read could
get scheduled quickly and they wouldn't be intermittant.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

