Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135225AbRDZJKK>; Thu, 26 Apr 2001 05:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135223AbRDZJJt>; Thu, 26 Apr 2001 05:09:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:42761 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135225AbRDZJJk>; Thu, 26 Apr 2001 05:09:40 -0400
Date: Thu, 26 Apr 2001 04:29:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104261043330.292-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0104260421480.1267-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Mike Galbraith wrote:

> On Thu, 26 Apr 2001, Marcelo Tosatti wrote:
> 
> > > (I can get it to under 9 with MUCH extremely ugly tinkering.  I've done
> > > this enough to know that I _should_ be able to do 8 1/2 minutes ~easily)
> >
> > Which kind of changes you're doing to get better performance on this test?
> 
> :)
> 
> 2.4.4.pre7.virgin
> real    11m33.589s
> user    7m57.790s
> sys     0m38.730s
> 
> 2.4.4.pre7.sillyness
> real    9m30.336s
> user    7m55.270s
> sys     0m38.510s

Have you tried to tune SWAP_SHIFT and the priority used inside swap_out()
to see if you can make pte deactivation less aggressive ?

If you get the desired effect tuning those values and you end up with the
conclusion that this tuning is a good change for most "common workloads",
it can be integrated in the main kernel.


