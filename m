Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316267AbSETTjI>; Mon, 20 May 2002 15:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316272AbSETTjH>; Mon, 20 May 2002 15:39:07 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:5643 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316267AbSETTjG>; Mon, 20 May 2002 15:39:06 -0400
Date: Mon, 20 May 2002 16:38:15 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug with shared memory.
In-Reply-To: <1232903251.1021886554@[10.10.2.3]>
Message-ID: <Pine.LNX.4.44L.0205201630050.24352-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Martin J. Bligh wrote:

> 1) Running Oracle apps, doing raw IO. We are running an -aa kernel
> on this machine, and it doesn't help.

> So, we haven't really given Andrea's patch a fair test yet. If you
> guys can agree which the better approach is by just discussing it,

One thing that seems to be missing in Linux are proper VM
statistics. There is no way handwaving and discussions are
going to be better than a measurement of what's going on
inside the VM.

Treating the different VM patch sets as black boxes with
benchmarks will show us which VM works best for which
benchmark, but it won't show us why or how to combine the
good features of the different VMs...

I think good statistics to start would be the traditional
page fault rate (pf), page free rate (fr), page scan rate
(sr), reclaims (re), pageout (po), pagein (pi) and some
variation of iowait stats.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

