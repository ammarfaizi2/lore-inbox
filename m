Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264016AbRFNUbS>; Thu, 14 Jun 2001 16:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264027AbRFNUbI>; Thu, 14 Jun 2001 16:31:08 -0400
Received: from maile.telia.com ([194.22.190.16]:59335 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S264016AbRFNUa4>;
	Thu, 14 Jun 2001 16:30:56 -0400
Message-Id: <200106142030.f5EKUWH19842@maile.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
Date: Thu, 14 Jun 2001 22:23:44 +0200
X-Mailer: KMail [version 1.2.2]
In-Reply-To: <Pine.LNX.4.21.0106140013000.14934-100000@imladris.rielhome.conectiva> <01061410474103.00879@starship>
In-Reply-To: <01061410474103.00879@starship>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 June 2001 10:47, Daniel Phillips wrote:
> On Thursday 14 June 2001 05:16, Rik van Riel wrote:
> > On Wed, 13 Jun 2001, Tom Sightler wrote:
> > > Quoting Rik van Riel <riel@conectiva.com.br>:
> > > > After the initial burst, the system should stabilise,
> > > > starting the writeout of pages before we run low on
> > > > memory. How to handle the initial burst is something
> > > > I haven't figured out yet ... ;)
> > >
> > > Well, at least I know that this is expected with the VM, although I do
> > > still think this is bad behavior.  If my disk is idle why would I wait
> > > until I have greater than 100MB of data to write before I finally
> > > start actually moving some data to disk?
> >
> > The file _could_ be a temporary file, which gets removed
> > before we'd get around to writing it to disk. Sure, the
> > chances of this happening with a single file are close to
> > zero, but having 100MB from 200 different temp files on a
> > shell server isn't unreasonable to expect.
>
> This still doesn't make sense if the disk bandwidth isn't being used.
>

It does if you are running on a laptop. Then you do not want the pages
go out all the time. Disk has gone too sleep, needs to start to write a few
pages, stays idle for a while, goes to sleep, a few more pages, ...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

