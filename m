Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268547AbTCALmI>; Sat, 1 Mar 2003 06:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268548AbTCALmI>; Sat, 1 Mar 2003 06:42:08 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:49597 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S268547AbTCALmG>; Sat, 1 Mar 2003 06:42:06 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       linux-kernel@vger.kernel.org
Date: Sat, 1 Mar 2003 03:51:04 -0800 (PST)
Subject: Re: anticipatory scheduling questions
In-Reply-To: <20030301024024.52aefd7a.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303010350180.17904-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wasn't there something about Evolution having problems with the change to
child-runs-first-on-fork logic several months ago?

David Lang

On Sat, 1 Mar 2003, Andrew Morton wrote:

> Date: Sat, 1 Mar 2003 02:40:24 -0800
> From: Andrew Morton <akpm@digeo.com>
> To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: anticipatory scheduling questions
>
> "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:
> >
> > ----- Original Message -----
> > > > It wasn't a typo... In fact, both deadline and AS give roughly the same
> > > > timings (one second up or down). But I
> > > > still don't understand why 2.5 is performing so much worse than 2.4.
> > >
> > > Me either.  It's a bug.
> > >
> > > Does basic 2.5.63 do the same thing?  Do you have a feel for when it started
> > > happening?
> >
> > This has happened since the moment I switched from 2.4 to 2.5.63-mm1.
>
> You have not actually said whether 2.5.63 base exhibits the same problem.
> From the vmstat traces it appears that the answer is "yes"?
>
> > > > Could a "vmstat" or "iostat" dump be interesting?
> > > 2.4 versus 2.5 would be interesting, yes.
> >
> > I have retested this with 2.4.20-2.54, 2.5.63 and 2.5.63-mm1...
> > and have attached the files to this message
>
> Thanks.  Note how 2.4 is consuming a few percent CPU, whereas 2.5 is
> consuming 100%.  Approximately half of it system time.
>
> It does appear that some change in 2.5 has caused evolution to go berserk
> during this operation.
>
>
> > (I think pasting them
> > here would result in wrapping, making it harder to read).
> >
> > If you need more testing or benchmarking, ask for it :-)
>
> Thanks for your patience.
>
> The next step please is:
>
> a) run top during the operation, work out which process is chewing all
>    that CPU.  Presumably it will be evolution or aspell
>
> b) Do it again and this time run
>
> 	strace -p $(pidof evolution)	# or aspell
>
> This will tell us what it is up to.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
