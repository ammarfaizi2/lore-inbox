Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318999AbSH1Vw7>; Wed, 28 Aug 2002 17:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319013AbSH1Vw7>; Wed, 28 Aug 2002 17:52:59 -0400
Received: from [195.39.17.254] ([195.39.17.254]:9600 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318999AbSH1Vw6>;
	Wed, 28 Aug 2002 17:52:58 -0400
Date: Wed, 28 Aug 2002 12:42:04 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: yodaiken@fsmlabs.com, Mark Hounschell <markh@compro.net>,
       "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: interrupt latency
Message-ID: <20020828124204.B39@toy.ucw.cz>
References: <20020827135400.A31990@hq.fsmlabs.com> <Pine.LNX.3.95.1020827160243.11549A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.95.1020827160243.11549A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Aug 27, 2002 at 04:44:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On Tue, Aug 27, 2002 at 02:01:43PM -0400, Richard B. Johnson wrote:
> > > This cannot be. A stock kernel-2.4.18, running a 133 MHz AMD-SC520,
> > > (like a i586) with a 33 MHz bus, handles interrupts off IRQ7 (the lowest
> > > priority), from the 'printer port' at well over 75,000 per second without
> > > skipping a beat or missing an edge. This means that latency is at least
> > > as good as 1/57,000 sec = 0.013 microseconds.
> > 
> > Assuming you mean 75,000 then ... 
> > Thats 0.013 MILLISECONDS which is 13 microseconds and its not likely.
> 
> Yes 13 microseconds.
> 
> > I bet that your data source drops data or looks at some handshake
> > pins on the parallel connect.
> > 
> 
> No. You can easily read into memory 75,000 bytes per second from the
> parallel port, hell RS-232C will do 22,400++ bytes per second (224,000
> baud) on a Windows machine, done all the while to feed a PROM burner. I
> never measured Linux RS-232C, but it's got to be at least as good.

There's >16bytes FIFO at the rs-232, and kernel uses flip buffers so
that it does nlot have to wake userspace each time.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

