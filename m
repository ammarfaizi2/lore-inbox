Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313758AbSDPQ0h>; Tue, 16 Apr 2002 12:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313759AbSDPQ0g>; Tue, 16 Apr 2002 12:26:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65029 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313758AbSDPQ0f>; Tue, 16 Apr 2002 12:26:35 -0400
Subject: Re: IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
To: andrea@suse.de (Andrea Arcangeli)
Date: Tue, 16 Apr 2002 17:09:17 +0100 (BST)
Cc: jfranosc@physik.tu-muenchen.de (Moritz Franosch), marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020416165358.E29747@dualathlon.random> from "Andrea Arcangeli" at Apr 16, 2002 04:53:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xVW9-0000Fq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The problem is that writing to a DVD-RAM, ZIP or MO device almost
> > totally blocks reading from a _different_ device. Here is some data.

Yes I saw this with M/O disks, thats one reason the -ac tree doesn't adopt
all the ll_rw_blk/elevator changes from the vanilla tree.

> > DVD-RAM while reading from the (fast) 130GB HDD (benchmark 2) almost
> > totally blocks the read process. Under 2.4.19-rc5, it takes 14 times

You'll see this on other things too. Large file creates seem to basically
stall anything wanting swap

> > benchmarks 1-4, kernel 2.4.19-pre5 performed much worse than
> > 2.4.18. The reason may be that the main throughput stems from the
> > short moments where, for what reason whatsoever, read speed increases

Fairness, throughput, latency - pick any two..  

> Right fix is different but not suitable for 2.4.

Curious - what do you think the right fix is ?
