Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSDQPf7>; Wed, 17 Apr 2002 11:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSDQPf6>; Wed, 17 Apr 2002 11:35:58 -0400
Received: from synapse.t30.physik.tu-muenchen.de ([129.187.186.221]:2243 "EHLO
	synapse.t30.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S290818AbSDQPf6>; Wed, 17 Apr 2002 11:35:58 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrea Arcangeli <andrea@suse.de>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
In-Reply-To: <Pine.LNX.4.44L.0204161236320.16531-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=US-ASCII
From: Moritz Franosch <jfranosc@physik.tu-muenchen.de>
Date: 17 Apr 2002 17:35:53 +0200
Message-ID: <rxxg01utk12.fsf@synapse.t30.physik.tu-muenchen.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Judging from the performance regression above it would seem the
> new defaults suck rocks.

I first thought that 2.4.19-pre5 would be better than 2.4.18 because
vmstat showed that 2.4.19-pre5 could still read 1-2 MB per second from
HDD while writing to DVD-RAM, whereas 2.4.18 blocked totally for more
than 10 seconds or so. But there are short moments under both kernels
(with default bdflush parameters) where you get data from HDD at a
very high rate before it drops again. It seems the main throughput
over a long time stems from these short moments.


> Can we please stop optimising Linux for a single workload benchmark
> and start tuning it for the common case of running multiple kinds
> of applications and making sure one application can't mess up the
> others ?
> 
> Personally I couldn't care less if my tar went 30% faster if it
> meant having my desktop unresponsive for the whole time.

That's why I did the benchmarks in the first place, because my desktop
was unresponsive while writing to DVD-RAM.


Moritz


-- 
Dipl.-Phys. Moritz Franosch
http://Franosch.org
