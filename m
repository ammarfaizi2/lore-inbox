Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290351AbSAPEPg>; Tue, 15 Jan 2002 23:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290347AbSAPEP1>; Tue, 15 Jan 2002 23:15:27 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:38785
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S290346AbSAPEPM>; Tue, 15 Jan 2002 23:15:12 -0500
Date: Tue, 15 Jan 2002 22:58:36 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Rob Landley <landley@trommello.org>
Cc: Anton Altaparmakov <aia21@cus.cam.ac.uk>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020115225836.B4658@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Rob Landley <landley@trommello.org>,
	Anton Altaparmakov <aia21@cus.cam.ac.uk>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20020115145324.A5772@thyrsus.com> <Pine.SOL.3.96.1020115201156.26402C-100000@libra.cus.cam.ac.uk> <20020115152445.B6308@thyrsus.com> <20020116034147.CRIZ26021.femail12.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020116034147.CRIZ26021.femail12.sdc1.sfba.home.com@there>; from landley@trommello.org on Tue, Jan 15, 2002 at 02:30:28PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org>:
> Eric and I disagree on the behavior of "make autoprobe".  He likes the 
> concept of "freezing" symbols, which says if the autoprober detected a 
> configuration setting, the question shouldn't show up and give you the 
> opportunity to disagree.  (Not confusing Aunt Tillie, with her LCSE from 
> CompTIA (and apparently has recently moved in with Alan Cox), with questions 
> that she's more likely to screw up than improve.)

Note, everyone else, that the freezing only happens on "make autoprobe".
The config.out that "make autoconfigure" writes is not frozen.
 
> Personally, I think that if you turn on "expert" mode, you should be
> able to override anything.  I haven't complained much because there
> is an easy workaround: Although the autoprober puts the "frozen"
> flag on the symbols it finds, menuconfig doesn't save them out :).

Correction: menuconfig *does* save out frozen symbols, but it saves
them unfrozen.

> So just run menuconfig twice and you can edit everything that got
> autoprobed...

This "workaround" is entirely intentional.

> (Now the standard configuration DOES freeze, and therefore hide, the
> "which architecture am I building for" question.  It would be nice
> if "make menuconfig" would let you do a cross-compile simply by
> selecting your architecture.  I understand why this isn't supported
> though: to properly build most architectures other than X86, you
> have to apply patches to Linus's tree.  And the make would have to
> tell gcc to cross-compile, which most gcc builds don't know how to
> do and the makefiles don't seem to support anyway...)

Actually, this kind of cross-configuration is already fully supported.
The normal way of calling the configurator, through the Makefile,
passes -D$(ARCH) -- but if you call it without an architecture symbol
frozen by command-line option, architecture will be the first question
you're asked.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

All forms of government are pernicious, including good government.
	-- Edward Abbey
