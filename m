Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWBTOWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWBTOWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWBTOWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:22:44 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52454 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030235AbWBTOWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:22:43 -0500
Date: Mon, 20 Feb 2006 15:22:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: dtor_core@ameritech.net
Cc: Lee Revell <rlrevell@joe-job.com>, Matthias Hensler <matthias@wspse.de>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220142242.GA1673@atrey.karlin.mff.cuni.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz> <200602110116.57639.sebas@kde.org> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140429758.3429.1.camel@mindpipe> <d120d5000602200601l31382264i7c0ef5bdf3d3829a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000602200601l31382264i7c0ef5bdf3d3829a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2/20/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> > > > It is slightly slower,
> > >
> > > Sorry, but that is just unacceptable.
> >
> > Um... suspend2 puts extra tests into really hot paths like fork(), which
> > is equally unacceptable to many people.
> >
> 
> How bad is it really? From what I saw marking that swsuspend2 branch
> with "unlikely" should help the hot path.

Not too bad, really.

> > Why can't people understand that arguing "it works" without any
> > consideration of possible performance tradeoffs is not a good enough
> > argument for merging?
> 
> Many of Pavel's arguments are not about performance tradeoffs but
> about perceived complexity of the code. I think if Nigel could run a
> clean up on his implementation and split it into couple of largish
> (not for inclusion but for general overview) pieces, like separate
> arch support, generally useful bits and the rest it would allow seeing
> more clearly how big and invasive swsuspend2 core is.

I have so many complains I do not know what to complain about,
first. My main one is:

"This can be done in userspace" (on recent -mm).

then there are some more, like "this is 14000 lines of code" and "it
touches places it should not really touch" (and maybe "its author does
not understand how linux development works", to some extent).
								Pavel
-- 
Thanks, Sharp!
