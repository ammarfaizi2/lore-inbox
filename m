Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283123AbRLDOob>; Tue, 4 Dec 2001 09:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283503AbRLDOmt>; Tue, 4 Dec 2001 09:42:49 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:29875
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283614AbRLDNZk>; Tue, 4 Dec 2001 08:25:40 -0500
Date: Tue, 4 Dec 2001 08:16:40 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204081640.A12658@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204140050.A10691@caldera.de>; from hch@caldera.de on Tue, Dec 04, 2001 at 02:00:50PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@caldera.de>:
> There is a CML1 language specification, as written down in a file, namely
> Documentation/kbuild/config-language.txt in the kernel tree.

A specification which, according to its author, is incomplete.

> There is one tool (mconfig) which has a yacc-parser that implements that
> specification completly, and some horrid ugly scripts in the tree that
> parse them in a more or less working way.  There also are a number of
> other tools I don't know to much about that understand the language as
> well.

N separate implementations means N dialects and N**2 compatibility problems.
Nicer just to have *one* parser, *one* compiler, and *one* service class that
supports several thin front-end layers, yes?  No?
 
> All of these tools just require the runtime contained in the LSB and no
> funky additional script languages.  Also none needs a binary intermediate
> representation of the config.

I quote Linus at the 2.5 kernel summit: "Python is not an issue."
Unless and until he changes his mind about that, waving around this
kind of argument is likely to do your case more harm than good.

If you want to re-open the case for saving CML1, you'd be better off
demonstrating how CML1 can be used to (a) automatically do implied 
side-effects when a symbol is changed, (b) guarantee that the user
cannot generate a configuration that violates stated invariants, and 
(c) unify the configuration tree so that the equivalents of arch/*
files never suffer from lag or skew when an architecture-independent
feature is added to the kernel.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Where rights secured by the Constitution are involved, there can be no
rule making or legislation which would abrogate them.
        -- Miranda vs. Arizona, 384 US 436 p. 491
