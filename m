Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbRDPMC1>; Mon, 16 Apr 2001 08:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131300AbRDPMCR>; Mon, 16 Apr 2001 08:02:17 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:41221 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S131254AbRDPMCF>;
	Mon, 16 Apr 2001 08:02:05 -0400
Date: Fri, 13 Apr 2001 00:26:46 +0000
From: Pavel Machek <pavel@suse.cz>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010413002645.B43@(none)>
In-Reply-To: <20010405000215.A599@bug.ucw.cz> <9b04food@ncc1701.cistron.net> <9b052eod@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <9b052eod@ncc1701.cistron.net>; from miquels@cistron-office.nl on Tue, Apr 10, 2001 at 11:30:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In article <9b04food@ncc1701.cistron.net>,
> Miquel van Smoorenburg <miquels@cistron-office.nl> wrote:
> >SIGTERM is a bad choise. Right now, init ignores SIGTERM. For
> >good reason; on some (many?) systems, the shutdown scripts
> >include "kill -15 -1; sleep 2; kill -9 -1". The "-1" means
> >"all processes except me". That means init will get hit with
> >SIGTERM occasionally during shutdown, and that might cause
> >weird things to happen.
> >
> >Perhaps SIGUSR1 ?
> 
> In the immortal words of Max Headroom, t-t-talking to myself ;)
> 
> In fact, the kernel should probably use a real-time signal
> with si_code set to 1 for ctrl-alt-del, 2 for the powerbutton etc.
> 
> It should first check if process 1 (init) installed a handler
> for that real-time signal. If not, it should use the old
> signals (SIGINT for ctrl-alt-del, SIGWINCH for kbrequest).

This is ugly as night, but SIGUSR1 looks okay.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

