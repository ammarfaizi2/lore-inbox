Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRDPWyN>; Mon, 16 Apr 2001 18:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132396AbRDPWyD>; Mon, 16 Apr 2001 18:54:03 -0400
Received: from lange.hostnamen.sind-doof.de ([212.15.192.219]:60178 "HELO
	xena.sind-doof.de") by vger.kernel.org with SMTP id <S131590AbRDPWxp>;
	Mon, 16 Apr 2001 18:53:45 -0400
Date: Tue, 17 Apr 2001 00:38:11 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010417003811.A4385@kallisto.sind-doof.de>
Mail-Followup-To: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20010416232748.A385@bug.ucw.cz> <Pine.LNX.4.31.0104162336450.27343-100000@phobos.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104162336450.27343-100000@phobos.fachschaften.tu-muenchen.de>; from Simon.Richter@phobos.fachschaften.tu-muenchen.de on Mon, Apr 16, 2001 at 11:44:20PM +0200
X-Operating-System: Debian GNU/Linux (Linux 2.4.3-ac5-int1-nf20010413-dc1 i686)
X-Disclaimer: Are you really taking me serious?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 16, 2001 at 11:44:20PM +0200, Simon Richter wrote:
> 
> Okay, but at least take a better signal than SIGINT, probably one that the
> init maintainers like so it gets adopted faster (or extend SIGPWR).

Extending SIGPWR will break inits not yet supporting the extensions,
so this is IMO not an option. There should be used some other signal
which is simply ignored by an old init.

If we are actually introducing this new signal, maybe we should in
turn also provide for a generic init signalling API which could
be used later by other subsystems also? The distribution of such
events to other userspace processes (if there are some that want to
receive a subset of the events) can be perfectly done by init, so we
should IMO keep this stuff out of the kernel (I don't think that the
processing of such events will ever be performance critical).

Andreas
-- 
Of course you can't flap your arms and fly to the moon.  After a while you'd
run out of air to push against.

