Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSDQPrj>; Wed, 17 Apr 2002 11:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSDQPri>; Wed, 17 Apr 2002 11:47:38 -0400
Received: from synapse.t30.physik.tu-muenchen.de ([129.187.186.221]:3011 "EHLO
	synapse.t30.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S290593AbSDQPri>; Wed, 17 Apr 2002 11:47:38 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andrea@suse.de (Andrea Arcangeli), marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
In-Reply-To: <E16xVW9-0000Fq-00@the-village.bc.nu>
Content-Type: text/plain; charset=US-ASCII
From: Moritz Franosch <jfranosc@physik.tu-muenchen.de>
Date: 17 Apr 2002 17:47:27 +0200
Message-ID: <rxxbscitjhs.fsf@synapse.t30.physik.tu-muenchen.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > > benchmarks 1-4, kernel 2.4.19-pre5 performed much worse than
> > > 2.4.18. The reason may be that the main throughput stems from the
> > > short moments where, for what reason whatsoever, read speed increases
> 
> Fairness, throughput, latency - pick any two..  

That's exactly the point. Writing large files to DVD-RAM leads to low
throughput when reading from HDD, long latencies and doesn't even
let the HDD read as mush data as is written to DVD-RAM (with 2.4.18),
which is very unfair.

My benchmarks show bad throughput. What I first observed was bad
latency when writing to DVD-RAM (no mouse movement for 3 seconds or
so, long times switching between applications, text output delayed
when typing). Fairness shouldn't be an issue because 2.4.18/19-pre5
are also bad when both tested disks are on different IDE controllers,
therefore no resources must be shared between the reading and the
writing process (except RAM for cache, but there is plenty).

Moritz


-- 
Dipl.-Phys. Moritz Franosch
http://Franosch.org
