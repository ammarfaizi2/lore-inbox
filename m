Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292291AbSBBOxU>; Sat, 2 Feb 2002 09:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292293AbSBBOxK>; Sat, 2 Feb 2002 09:53:10 -0500
Received: from mustard.heime.net ([194.234.65.222]:14252 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S292291AbSBBOxE>; Sat, 2 Feb 2002 09:53:04 -0500
Date: Sat, 2 Feb 2002 15:52:53 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Jens Axboe <axboe@suse.de>
cc: Roger Larsson <roger.larsson@norran.net>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Errors in the VM - detailed
In-Reply-To: <20020201195743.J12156@suse.de>
Message-ID: <Pine.LNX.4.30.0202021550560.10436-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hmm.. suppose this is the problem anyway and that Jens patch was not enough.
> > How do the disk drive sound during the test?
> >
> > Does it start to sound more when performance goes down?
>
> Yes that would be interesting to know, if the disk becomes seek bound.

The performance never goes down. It's stable @ ~40-43 MB/s. It DID go
down, but that was before -rmap11c. Then the problem was in the VM

> Probably, my patch was really just a quick try to see if it changed
> anything.
>
> > Number of READ limits the number of concurrent streams.
> > And READA limits the maximum total read ahead.
>
> Correct, Roy you could try and change the READA balance by allocating
> lots more READA requests. Simply play around with the
> queue_nr_requests / 4 setting. Try something "absurd" like
> queue_nr_requests << 2 or even bigger.

sure.

where do I change this???

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

