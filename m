Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbSKILNz>; Sat, 9 Nov 2002 06:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbSKILNz>; Sat, 9 Nov 2002 06:13:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11221 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264644AbSKILNy>;
	Sat, 9 Nov 2002 06:13:54 -0500
Date: Sat, 9 Nov 2002 12:20:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021109112018.GA31134@suse.de>
References: <200211091300.32127.conman@kolivas.net> <3DCC74B0.47A462A9@digeo.com> <200211091426.54403.conman@kolivas.net> <3DCC8BCB.F5E39AB7@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCC8BCB.F5E39AB7@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08 2002, Andrew Morton wrote:
> Con Kolivas wrote:
> > 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > >Con Kolivas wrote:
> > >> io_load:
> > >> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > >> 2.4.18 [3]              474.1   15      36      10      6.64
> > >> 2.4.19 [3]              492.6   14      38      10      6.90
> > >> 2.4.19-ck9 [2]          140.6   49      5       5       1.97
> > >> 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
> > >> 2.4.20-rc1aa1 [1]       1132.5  6       90      10      15.86
> > >
> > >2.4.20-pre3 included some elevator changes.  I assume they are the
> > >cause of this.  Those changes have propagated into Alan's and Andrea's
> > >kernels.   Hence they have significantly impacted the responsiveness
> > >of all mainstream 2.4 kernels under heavy writes.
> > >
> > >(The -ck patch includes rmap14b which includes the read-latency2 thing)
> > 
> > Thanks for the explanation. I should have said this was ck with compressed
> > caching; not rmap.
> > 
> 
> hrm.  In that case I'll shut up with the speculating.
> 
> You're showing a big shift in behaviour between 2.4.19 and 2.4.20-rc1.
> Maybe it doesn't translate to worsened interactivity.  Needs more
> testing and anaysis.

The merging and seek accounting in 2.4.19 is completely off, it doesn't
make any sense. 2.4.20-rc1 should be sanely tweakable.

-- 
Jens Axboe

