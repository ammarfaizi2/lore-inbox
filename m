Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132689AbRDQOiQ>; Tue, 17 Apr 2001 10:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132664AbRDQOiI>; Tue, 17 Apr 2001 10:38:08 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:16912 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132689AbRDQOhz>;
	Tue, 17 Apr 2001 10:37:55 -0400
Date: Tue, 17 Apr 2001 10:38:56 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: John Cowan <cowan@mercury.ccil.org>
Cc: james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML2 1.1.3 is available
Message-ID: <20010417103856.A27762@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	John Cowan <cowan@mercury.ccil.org>,
	james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010416205556.A22960@thyrsus.com> <E14pTOH-0007ex-00@mercury.ccil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14pTOH-0007ex-00@mercury.ccil.org>; from cowan@mercury.ccil.org on Tue, Apr 17, 2001 at 07:11:25AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Cowan <cowan@mercury.ccil.org>:
> > If there were already a library in ths stock Python distribution to digest
> > .Xdefaults files I might consider this.  Perhaps I'll write one.  But I'm
> > not going to bulk up the CML2 code with this marginal feature.
> 
> Then support a private mechanism if you must.  But leaving colors hard-coded
> in the application is just as bad as leaving strings hard-coded there, and
> for the same reasons: it's a point that needs to be adjustable for
> accessibility.  The whole point of CML2 is to make kernel configuration something
> that Aunt Tillie (or a reasonable facsimile thereof) can do, and we are
> all Aunt Tillies from time to time.  That includes differing standards of
> readability, quite apart from the differences in monitors that make
> a Mac user's *red* look more like *orange* to me (and CML2 will be
> used, perhaps even more often used, off stock x86 hardware).
> 
> Without counting, I estimate that 50% of the problem (I won't say "bug"
> in this context) reports you have had since 1.0.0 have been about colors.
> The more users you get, the more such complaints there will be.  Nail
> this one to the wall before people start demanding contradictory changes.
> 
> If you don't have a full X resources parser, then do a trivial scan of
> just .Xdefaults and look for a few fixed cases like
> 
> 	CMLConfigure*YColor: 0xrrbbgg
> 	CMLConfigure*NColor: 0xrrbbgg
> 
> etc. etc.  Or provide a private .rc file.  Or *something*.

Unfortunately, life is not so simple.

X speaks RRBBGG -- or does it?  Suppose the user isn't running in
24-bit true-color mode; do I do my own dithering or quantization?  The
terminal emulators only know about the 16 EGA colors.  So, should I
support separate resource formats for X and menuconfig cases?  But
wait!  The Linux console does RRBBGG.

Other possibility: support only the 16 EGA colors by name.  But if I do that,
some of the X colors are just *wrong* on standard gray background (cyan is
a good example).

There's no way to get this right.  So I choose to get it wrong in a simple
way rather than a complex, costly way.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Extremism in the defense of liberty is no vice; moderation in the
pursuit of justice is no virtue."
	-- Barry Goldwater (actually written by Karl Hess)
