Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282968AbRLEGxI>; Wed, 5 Dec 2001 01:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283001AbRLEGw6>; Wed, 5 Dec 2001 01:52:58 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:21387 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S282968AbRLEGwu>; Wed, 5 Dec 2001 01:52:50 -0500
Message-ID: <001001c17d59$34f976d0$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>
Cc: <Martin.Bligh@us.ibm.com>, <riel@conectiva.com.br>, <lars.spam@nocrew.org>,
        <alan@lxorguk.ukuu.org.uk>, <hps@intermeta.de>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20011204163646.M7439@work.bitmover.com><20011204.183601.22018455.davem@redhat.com><20011204192317.N7439@work.bitmover.com> <20011204.220511.71088411.davem@redhat.com>
Subject: Re: SMP/cc Cluster description
Date: Tue, 4 Dec 2001 23:51:03 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
From: "David S. Miller" <davem@redhat.com>
To: <lm@bitmover.com>
Cc: <Martin.Bligh@us.ibm.com>; <riel@conectiva.com.br>;
<lars.spam@nocrew.org>; <alan@lxorguk.ukuu.org.uk>; <hps@intermeta.de>;
<linux-kernel@vger.kernel.org>
Sent: Tuesday, December 04, 2001 11:05 PM
Subject: Re: SMP/cc Cluster description


>    From: Larry McVoy <lm@bitmover.com>
>    Date: Tue, 4 Dec 2001 19:23:17 -0800
>
> Even more boldly, I claim that Linux's current ipv4 scales further
> than anything coming out of Sun engineering.  From my perspective
> Sun's scalability efforts are more in line with "rubber-stamp"
> per-object locking when things show up in the profiles than anything
> else.  Their networking is really big and fat.  For example the
> Solaris per-socket TCP information is nearly 4 times the size of that
> in Linux (last time I checked their headers).  And as we all know
> their stuff sits on top of some thick infrastructure (ie. STREAMS)
> (OK, here is where someone pops up a realistic networking benchmark
> where we scale worse than Solaris.  I would welcome such a retort
> because it'd probably end up being a really simple thing to fix.)

David,

The job you did on ipv4 is quite excellent.  I multi-threaded the ODI layer
in NetWare,
and I have reviewed your work and it's as good as anything out there.  The
fewer locks,
the better.  Also, I agree that Sun's "hot air" regarding their SMP is just
that.  Sure, they
have a greart priority inheritenace model, but big f_cking deal.  sleep
locks and their behaviors
have little to do with I./O scaling on interrupt paths, other than to
increase the background
transaction activity on the memory bus.

Your ipv4 work is not perfect, but it's certainly good enough.  We found
with NetWare that SMP
scaling was tough to achieve since the processor was never the bottleneck --
the I/O bus was.
Uniprocessor NetWare 3.12 still runs circles around Linux or anything else,
and it's not
multithreaded, just well optimaized (and hand coded in assembler).

There are a few optimizations you could still to do to make it even faster,
but these are off line
discussions.  :-)

Jeff
.
>
> Franks a lot,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

