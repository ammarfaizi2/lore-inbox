Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311327AbSCLUJ0>; Tue, 12 Mar 2002 15:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311258AbSCLUJQ>; Tue, 12 Mar 2002 15:09:16 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:58896 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S311327AbSCLUJH>; Tue, 12 Mar 2002 15:09:07 -0500
Date: Tue, 12 Mar 2002 16:02:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jens Axboe <axboe@suse.de>
Cc: Karsten Weiss <knweiss@gmx.de>, lkml <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <20020312134631.GE1473@suse.de>
Message-ID: <Pine.LNX.4.21.0203121558300.3462-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Mar 2002, Jens Axboe wrote:

> On Tue, Mar 12 2002, Karsten Weiss wrote:
> > > Here goes -pre3, with the new IDE code. It has been stable enough time in
> 
> Oh good god, the nr_sectors/current_nr_sectors for the pio data phases
> haven't been fixed _yet_?!
> 
> task_in_intr()
> {
> 	...
> 	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
> }
> 
> And that's just one instance. Good luck running 2.4.19-pre3, this is
> just so badly broken I can't find words to explain it (again). It's
> really puzzling why this is still broken. I fixed it in 2.5 when the
> merge happened there, the issue has been known for at least that long. I
> can only recommend that no one uses 2.4.19-pre3!
> 
> Marcelo, at least apply the noop patch here. If I get motivated I'll fix
> the interrupt handlers as well, can't say I really want to though...

As I previously said, I will apply the noop patch.

I've read the flamewar which this mail generated, but I prefer to simply
ignore that: Its useless for me, it haven't explained me nothing which
matters (that is, the technical side of the problem Jens described).

So, Jens, could you please explain the problem in the interrupt handlers
in detail ?



