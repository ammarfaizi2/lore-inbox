Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbREAIbE>; Tue, 1 May 2001 04:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbREAIap>; Tue, 1 May 2001 04:30:45 -0400
Received: from duba04h04-0.dplanet.ch ([212.35.36.38]:20229 "EHLO
	duba04h04-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S131157AbREAIah>; Tue, 1 May 2001 04:30:37 -0400
Message-ID: <3AEE80A3.EB0ACEB1@dplanet.ch>
Date: Tue, 01 May 2001 11:23:47 +0200
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Peter Samuelson <peter@cadcamlab.org>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 1.3.1, 
 aka ...]
In-Reply-To: <20010427193501.A9805@thyrsus.com> <15084.12152.956561.490805@gargle.gargle.HOWL> <20010429183526.B32748@thyrsus.com> <15085.37569.205459.898540@gargle.gargle.HOWL> <20010430133932.B28849@thyrsus.com> <20010430141623.A15821@cadcamlab.org> <20010430152536.A29699@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Peter Samuelson <peter@cadcamlab.org>:
> > [esr]
> > > Besides, right now the configurator has a simple invariant.  It will
> > > only accept consistent configurations
> >
> > So you are saying that the old 'vi .config; make oldconfig' trick is
> > officially unsupported?  That's too bad, it was quite handy.
> 
> Depends on how you define `unsupported'.  Make oldconfig will tell you
> exactly and unambiguously what was wrong with the configuration.  I think
> if you're hard-core enough to vi your config, you're hard-core enough to
> interpret and act on
> 
>     This configuration violates the following constraints:
>     (X86 and SMP==y) implies RTC!=n
> 
> without needing some wussy GUI holding your hand :-).

I think that a fundamental requirment is that 'make oldconfig' should
validate any configurations (also the wrong conf).
(If you correct your rules, our old .config can be invalid on a new
kernel, and we don't want regualary edit our .config).

My proposal is instaed of complain about configuration violatation,
you just wrote the possible correct configuration and prompt user to
select the correct configuration.
In the case you cite, e.g. oldconfig shoud prompt:
  1) SMP=n
  2) RTC=m
  3) RTC=y
(assuming the ARCH is invariant).

To simplify your life you can require only tty (or ev. also menu mode)
for
there question. User normally use oldconfig in tty mode for simplicity
(there
are normally only few questions, thus is simple to have the question
already
in order, without to perse nearly empy menus).

	giacomo
