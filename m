Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283481AbRL2PIK>; Sat, 29 Dec 2001 10:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283244AbRL2PHu>; Sat, 29 Dec 2001 10:07:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23559 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283268AbRL2PHn>;
	Sat, 29 Dec 2001 10:07:43 -0500
Date: Sat, 29 Dec 2001 16:07:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Message-ID: <20011229160730.A1821@suse.de>
In-Reply-To: <20011228115956.E2973@suse.de> <Pine.LNX.4.33L.0112281028070.24031-100000@imladris.surriel.com> <20011228133350.B834@suse.de> <m2666rta4t.fsf@pengo.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2666rta4t.fsf@pengo.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28 2001, Peter Osterlund wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > On Fri, Dec 28 2001, Rik van Riel wrote:
> > > On Fri, 28 Dec 2001, Jens Axboe wrote:
> > > >
> > > > Tried reading the source?
> > >
> > > As usual, without documentation you only know what the code
> > > does, not what it's supposed to do or why it does it.
> >
> > please look at the source before making such comments -- it's quite
> > adequately commented.
> 
> I agree, but I have one specific question though. What are the
> bi_end_io() functions supposed to return? The return value doesn't
> ever seem to be used (yet?), so reading the source code can not answer
> that question.

They were supposed to return 0 if the bio was completely done, or 1 if
there was remaining I/O to be done. Right now it's unused, so just
return 0 for success.

-- 
Jens Axboe

