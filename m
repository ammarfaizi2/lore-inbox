Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271891AbRH1Tm6>; Tue, 28 Aug 2001 15:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271892AbRH1Tms>; Tue, 28 Aug 2001 15:42:48 -0400
Received: from mustard.heime.net ([194.234.65.222]:36224 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S271891AbRH1Tmf>; Tue, 28 Aug 2001 15:42:35 -0400
Date: Tue, 28 Aug 2001 21:42:45 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Andrew Morton <akpm@zip.com.au>
cc: Jannik Rasmussen <jannik@east.no>, <linux-kernel@vger.kernel.org>
Subject: Re: Error 3c900 driver in 2.2.19?
In-Reply-To: <3B8BE0C9.78B12BB@zip.com.au>
Message-ID: <Pine.LNX.4.30.0108282142240.3147-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Aug 2001, Andrew Morton wrote:

> Roy Sigurd Karlsbakk wrote:
> >
> > > Networking needs to allocate memory at interrupt time.  This is
> > > referred to as "atomic allocation".  The only way in which this
> > > can be successful is for the VM system to ensure that there is
> > > a pool of immediately-allocatable memory lying around.
> > >
> > > The 2.2 kernel uses the tunables in /proc/sys/vm/freepages to
> > > decide how large that pool should be.  Machines which sustain
> > > a high network load commonly require more memory than the
> > > default freepages setting provides.  People who encounter network
> > > Rx allocation failures with 2.2 kernels do report that increasing
> > > the freepages tunables fixes the problem.
> > >
> > > -
> > >
> >
> > Thanks
> >
> > But... Should the server hang after experiencing problems with this? On
> > 2.2.19?
> >
>
> Absolutely not.  If the network driver experiences 32 successive
> memory allocation failures it will fall back to a timer-driven mode
> where it tries to refill its buffer ring once per second.  This
> code works.
>
> If your machine is completely locking up and needs a reset then
> something is presumably not handling out-of-memory correctly.
>
> What do you mean by "the server hangs"?

The server locked up and needed a hard reboot

roy

