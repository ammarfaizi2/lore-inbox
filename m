Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133101AbRDZElA>; Thu, 26 Apr 2001 00:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133099AbRDZEkl>; Thu, 26 Apr 2001 00:40:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41231 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S133098AbRDZEkb>; Thu, 26 Apr 2001 00:40:31 -0400
Date: Thu, 26 Apr 2001 00:00:35 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104260617020.566-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0104252352430.1101-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Mike Galbraith wrote:

> > Comments?
> 
> More of a question.  Neither Ingo's nor your patch makes any difference
> on my UP box (128mb PIII/500) doing make -j30.

Well, my patch incorporates Ingo's patch.

It is now integrated into pre7, btw. 

>  It is taking me 11 1/2
>  minutes to do this test (that's horrible).  Any idea why?~

Not really.

If you have concurrent swapping activity, pre7 should improve the
performance since all swap IO is asynchronous now. Only paths which really
need to stop and wait for the swap data are doing it. (eg do_swap_page)

> (I can get it to under 9 with MUCH extremely ugly tinkering.  I've done
> this enough to know that I _should_ be able to do 8 1/2 minutes ~easily)

Which kind of changes you're doing to get better performance on this test?

