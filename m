Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132576AbRDQJa5>; Tue, 17 Apr 2001 05:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbRDQJas>; Tue, 17 Apr 2001 05:30:48 -0400
Received: from lange.hostnamen.sind-doof.de ([212.15.192.219]:16900 "HELO
	xena.sind-doof.de") by vger.kernel.org with SMTP id <S132576AbRDQJaj>;
	Tue, 17 Apr 2001 05:30:39 -0400
Date: Tue, 17 Apr 2001 10:39:00 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010417103900.C4385@kallisto.sind-doof.de>
Mail-Followup-To: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20010417003811.A4385@kallisto.sind-doof.de> <Pine.LNX.4.31.0104170808080.6365-100000@phobos.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104170808080.6365-100000@phobos.fachschaften.tu-muenchen.de>; from Simon.Richter@phobos.fachschaften.tu-muenchen.de on Tue, Apr 17, 2001 at 08:16:00AM +0200
X-Operating-System: Debian GNU/Linux (Linux 2.4.3-ac5-int1-nf20010413-dc1 i686)
X-Disclaimer: Are you really taking me serious?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 08:16:00AM +0200, Simon Richter wrote:
> 
> > Extending SIGPWR will break inits not yet supporting the extensions,
> > so this is IMO not an option. There should be used some other signal
> > which is simply ignored by an old init.
> Make it a config option then; the short description says "read help", the
> long help says "you need init version x.y". People compiling their own
> kernels should know what they're doing, and distributors usually know what
> init they are packaging.

The problem with this is that there is no single init. Most
distribution run the same SysV init, but there are quite a few init
replacements around. Should we really break all of them? We can simply
use another signal and build a generic (and extensible) signalling
mechanism around it, so I don't really see a reason why we should
break old inits.

Andreas
-- 
Insults are effective only where emotion is present.
		-- Spock, "Who Mourns for Adonais?"  stardate 3468.1

