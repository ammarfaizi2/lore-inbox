Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132643AbQKZTHg>; Sun, 26 Nov 2000 14:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132611AbQKZTH1>; Sun, 26 Nov 2000 14:07:27 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:40186 "EHLO
        brutus.conectiva.com.br") by vger.kernel.org with ESMTP
        id <S132240AbQKZTGx>; Sun, 26 Nov 2000 14:06:53 -0500
Date: Sun, 26 Nov 2000 16:36:20 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Andrew Morton <andrewm@uow.edu.au>, "Mr. Big" <mrbig@sneaker.sch.bme.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: readonly /proc/sys/vm/freepages (was: Re: PROBLEM: crashing
 kernels)
In-Reply-To: <20001126143059.M13759@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.21.0011261623200.23375-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000, Ingo Oeser wrote:
> On Sun, Nov 26, 2000 at 10:49:50AM +1100, Andrew Morton wrote:
> > You may also get some benefit from running:
> > 
> > # echo "512 1024 1536" > /proc/sys/vm/freepages
> > 
> > after booting.
> 
> ... which is a NOOP on recent 2.4.0-testX-kernels. So please
> complain at Rik for this (CC'ed him) ;-)

I wasn't aware I studied at tu-chemnitz ;)

> It's simply not that easy to set in the new VM since we count
> the inactive_clean and/or inactive_dirty pages like free pages
> in some cases.

And also, because HIGHMEM pages are not at all usable for kernel
things, so simply reserving 20MB for network bursts isn't going
to help you when it's all in highmem pages ...

> > The default values are a little too low for
> > applications which are very network intensive.
> 
> Especially for low memory machines, which are dedicated only for
> this purpose. Many people use (embedded) Linux and a (embedded)
> PC to cheaply fill functionality gaps in industrial
> environments.

Indeed, I agree that we want this tunable back...

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
