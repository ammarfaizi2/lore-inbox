Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132564AbRAKQ1C>; Thu, 11 Jan 2001 11:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132565AbRAKQ0w>; Thu, 11 Jan 2001 11:26:52 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:54534 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S132564AbRAKQ0t>;
	Thu, 11 Jan 2001 11:26:49 -0500
Date: Thu, 11 Jan 2001 16:26:54 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Anton Blanchard <anton@linuxcare.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Benchmarking 2.2 and 2.4 using hdparm and dbench 1.1
Message-ID: <Pine.LNX.4.30.0101111625230.5727-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[regarding the buffer cache hash size and bad performance on machines
with little memory...  (<32MB)]

On Tue, 9 Jan 2001, Anton Blanchard wrote:
> > Where is the size defined, and is it easy to modify?
>
> Look in fs/buffer.c:buffer_init()

I experimented some, and increasing the huffer cache hash to the 2.2
levels helped a lot, especially for 16 MB memory.  The difference is huge,
64 kB in 2.2 vs 1 kB in 2.4 for a 32 MB memory machine.

> I havent done any testing on slow hardware and the high end stuff is
> definitely performing better in 2.4, but I agree we shouldn't forget
> about the slower stuff.

Being able to tune the machine for both high and low end systems is
neccessary, and if Linux can tune itself, that's of course the best.

> Narrowing down where the problem is would help. My guess is it is a TCP
> problem, can you check if it is performing worse in your case? (eg ftp
> something against 2.2 and 2.4)

Nope, TCP performance seems more or less unchanged.  I will keep
investigating, and get back when I have more info.

/Tobias


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
