Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273068AbTHKTni (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273015AbTHKTmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:42:22 -0400
Received: from pop.gmx.net ([213.165.64.20]:46007 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272980AbTHKTly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:41:54 -0400
Message-Id: <5.2.1.1.2.20030811212837.01975fa0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 11 Aug 2003 21:46:00 +0200
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH]O14int [SCHED_SOFTRR please]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200308112019.38613.roger.larsson@skelleftea.mail.telia.com
 >
References: <5.2.1.1.2.20030810122144.019bdb00@pop.gmx.net>
 <200308091036.18208.kernel@kolivas.org>
 <5.2.1.1.2.20030810122144.019bdb00@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:19 PM 8/11/2003 +0200, Roger Larsson wrote:
>On Sunday 10 August 2003 13.17, Mike Galbraith wrote:
> > At 01:48 AM 8/10/2003 -0700, Simon Kirby wrote:
> > >I am seeing similar starvation problems that others are seeing in these
> > >threads.  At first it was whenever I clicked a link in Mozilla -- xmms
> > >would stop, sometimes for a second or so, on a Celeron 466 MHz machine.
> >
> > Do you see this with test-X and Ingo's latest changes too?  I can only
> > imagine one scenario off the top of my head where this could happen; if
> > xmms exhausted a slice while STARVATION_LIMIT is exceeded, it could land in
> > the expired array and remain unserviced for the period of time it takes for
> > all tasks remaining in the active array to exhaust their slices.  Seems
> > like that should be pretty rare though.
> >
>
>xmms is a RT process - it does not really have interactivity problems...
>It will be extremely hard to fix this in a generic scheduler, instead
>let xmms be the RT process it is with SCHED_SOFTRR (or whatever
>it will be named).
>Do this for arts, and other audio/video path applications.

(For the scenario described, it doesn't matter what scheduler policy is used)

>Then start the race for interactivity tuning
>  (X, X applications, console, login, etc)
>
>interactivity = two-way
>         http://www.m-w.com/cgi-bin/dictionary?va=interactive
>
>Listening to music is not interactive.

?!?  <tilt> What makes you say that?  What in the world am I doing when I 
fire up xmms?
(can't be the two way thing... that's happening until I stop listening)

         -Mike

         -Mike 

