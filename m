Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131296AbRA3QU2>; Tue, 30 Jan 2001 11:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131383AbRA3QUS>; Tue, 30 Jan 2001 11:20:18 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:31109 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131296AbRA3QUG>; Tue, 30 Jan 2001 11:20:06 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A76E155.2030905@redhat.com> 
In-Reply-To: <3A76E155.2030905@redhat.com>  <3A75A70C.4050205@redhat.com> <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>, <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com> <20010129084410.B32652@hq.fsmlabs.com> <30672.980867280@redhat.com> 
To: Joe deBlaquiere <jadb@redhat.com>
Cc: yodaiken@fsmlabs.com, Andrew Morton <andrewm@uow.edu.au>,
        Nigel Gamble <nigel@nrg.org>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Jan 2001 16:19:14 +0000
Message-ID: <5797.980871554@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jadb@redhat.com said:
>  I wasn't thinking of running the kernel XIP from writable, but even
> trying to do that from the filesystem is a mess. If you're going to be
>  that way about it...

Heh. I am. Read-only XIP is going to be doable, but writable XIP means that
any time you start to write to the flash chip, you have to find all the
mappings of every page from that chip and mark them absent, then deal 
properly with faults on them; making processes sleep till the chip is in a 
readable state again. It's going to suck. Lots.

I'm not going to emulate our beloved leader and declare that it's never
going to be supported - I have no particular problem with someone doing
this, as long as I don't have to get too involved and it doesn't end up in
my CVS tree with me being the one who's expected to feed/justify it to
Linus.

> /me hands over the crackpipe

You don't want writable XIP. You just think you do, because you work for a 
software company and you're not allowed to call the hardware designers 
naughty names when they fail to realise that compression is far more useful 
than XIP and also cheaper, in 99% of cases.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
