Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282915AbRK1PN1>; Wed, 28 Nov 2001 10:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282908AbRK1PNQ>; Wed, 28 Nov 2001 10:13:16 -0500
Received: from [128.165.17.254] ([128.165.17.254]:62155 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S282156AbRK1PNI>; Wed, 28 Nov 2001 10:13:08 -0500
Date: Wed, 28 Nov 2001 08:13:05 -0700
From: Eric Weigle <ehw@lanl.gov>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Magic Lantern
Message-ID: <20011128081305.I22767@lanl.gov>
In-Reply-To: <Pine.LNX.3.95.1011128090654.10732B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1011128090654.10732B-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.18i
X-Eric-Unconspiracy: There ought to be a conspiracy
X-Editor: Vim, http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > "Richard B. Johnson" <root@chaos.analogic.com> writes:
> > > Are there currently any kernel hooks to support Magic Lantern?
> > > Basically, a "tee" to capture all network packets and pass them
> > > on to a filtering task without affecting normal network activity.
> > > It's like `tcpdump`, but allows packets to be inserted into the
> > > output queue as well without affecting normal network activity.
> > 
> > The af_packet module can read and write raw ethernet frames.
The af_packet module may also be fairly inefficient. If you need performance
over, say, a gigabit link, you may have trouble. I last used it one of the
earlier 2.4 series (2.4.8 I think) with the Acenic Tigon II gigE copper
cards to implement a network flooder; At that time a simple unoptimized loop
sending raw ethernet packets maxed out at at around 80Mbps, while the same loop
sending UDP packets maxed out at around 400. This may have been fixed by now,
I don't know... Just a warning.

-Eric

-- 
--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
