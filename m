Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbULQV7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbULQV7d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 16:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbULQV5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 16:57:45 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:51365 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262173AbULQVzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 16:55:55 -0500
Subject: Re: 2.6.10-rc3-mm1-V0.7.33-03 and NVidia wierdness, with
	workaround...
From: Steven Rostedt <rostedt@goodmis.org>
To: Valdis.Kletnieks@vt.edu
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200412172149.iBHLnsEP013332@turing-police.cc.vt.edu>
References: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu>
	 <1103300362.12664.53.camel@localhost.localdomain>
	 <1103303011.12664.58.camel@localhost.localdomain>
	 <200412171810.iBHIAQP3026387@turing-police.cc.vt.edu>
	 <1103313861.12664.71.camel@localhost.localdomain>
	 <200412172149.iBHLnsEP013332@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 17 Dec 2004 16:55:27 -0500
Message-Id: <1103320527.3538.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-17 at 16:49 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 17 Dec 2004 15:04:21 EST, Steven Rostedt said:
> 
> > Nope! I have the 6629. Actually, the patch you have for NV solved the
> > pgd_offset problem.
> 
> Glad to hear it, I'm just the messenger on that one (I forget which lkml
> denizen actually wrote/posted that one).
> 
> >                       But I'm amazed that you didn't get into the
> > may_sleep calls.

I keep typing may_sleep for some reason, it really gets annoying when
searching for that function ;-)

> 
> I'm actually not *that* surprised - my test base consists entirely of one Dell
> Latitude C840 laptop with a GeForce4 440 Go card, so there's no SMP issues or
> similar, and I don't do heavy 3D or anything unless xscreensaver decides to use
> a random OpenGL display hack. Most likely, your hardware and/or CONFIG_* setup
> is getting it into code paths that never get hit on my system. And the
> might_sleep() is almost certainly on one of those paths.
> 
> (For the record, I *did* see a few might_sleep hits on 2.6.10-rc2-mm4-V0.7.31-15,
> but they only hit sendmail, gpg, bash, and stuff like that, never an X-based program.)

I just sent my last email out just before I received this one.

Just for the record, I'm testing this on a SMP Athlon system (my main
desktop) and a SMP HT Thinkpad G41 (just hyper threaded, not really SMP,
but it does act the same).

-- Steve


