Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277702AbRJ1FFx>; Sun, 28 Oct 2001 01:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277710AbRJ1FFn>; Sun, 28 Oct 2001 01:05:43 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30971
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277703AbRJ1FFj>; Sun, 28 Oct 2001 01:05:39 -0400
Date: Sat, 27 Oct 2001 22:05:57 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: zlatko.calusic@iskon.hr, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
Message-ID: <20011027220557.A20280@mikef-linux.matchmail.com>
Mail-Followup-To: Giuliano Pochini <pochini@denise.shiny.it>,
	zlatko.calusic@iskon.hr, Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0110250920270.2184-100000@cesium.transmeta.com> <dnr8rqu30x.fsf@magla.zg.iskon.hr> <3BDAB344.CE25D5D@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BDAB344.CE25D5D@denise.shiny.it>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2001 at 03:14:44PM +0200, Giuliano Pochini wrote:
> 
> > block: 1024 slots per queue, batch=341
> > 
> > Wrote 600.00 MB in 71 seconds -> 8.39 MB/s (7.5 %CPU)
> > 
> > Still very spiky, and during the write disk is uncapable of doing any
> > reads. IOW, no serious application can be started before writing has
> > finished. Shouldn't we favour reads over writes? Or is it just that
> > the elevator is not doing its job right, so reads suffer?
> >
> >    procs                      memory    swap          io     system         cpu
> >  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
> >  0  1  1      0   3596    424 453416   0   0     0 40468  189   508   2   2  96
> 
> 341*127K = ~40M.
> 
> Batch is too high. It doesn't explain why reads get delayed so much, anyway.
> 

Try modifying the elivator queue length with elvtune.

BTW, 2.2.19 has the queue lengths in the hundreds, and 2.4.xx has it in the
thousands.  I've set 2.4 kernels back to the 2.2 defaults, and interactive
performance has gone up considerably.  These are subjective tests though.

Mike
