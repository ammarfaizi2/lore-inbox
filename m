Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131887AbRDQLL7>; Tue, 17 Apr 2001 07:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132118AbRDQLLt>; Tue, 17 Apr 2001 07:11:49 -0400
Received: from mercury.ccil.org ([192.190.237.100]:19973 "EHLO
	mercury.ccil.org") by vger.kernel.org with ESMTP id <S131887AbRDQLLi>;
	Tue, 17 Apr 2001 07:11:38 -0400
Subject: Re: [kbuild-devel] CML2 1.1.3 is available
In-Reply-To: <20010416205556.A22960@thyrsus.com> from "Eric S. Raymond" at "Apr
 16, 2001 08:55:56 pm"
To: esr@thyrsus.com
Date: Tue, 17 Apr 2001 07:11:25 -0400 (EDT)
CC: james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E14pTOH-0007ex-00@mercury.ccil.org>
From: John Cowan <cowan@mercury.ccil.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond scripsit:

> That way lies featuritis, IMO.

Only if you let it.

> If there were already a library in ths stock Python distribution to digest
> .Xdefaults files I might consider this.  Perhaps I'll write one.  But I'm
> not going to bulk up the CML2 code with this marginal feature.

Then support a private mechanism if you must.  But leaving colors hard-coded
in the application is just as bad as leaving strings hard-coded there, and
for the same reasons: it's a point that needs to be adjustable for
accessibility.  The whole point of CML2 is to make kernel configuration something
that Aunt Tillie (or a reasonable facsimile thereof) can do, and we are
all Aunt Tillies from time to time.  That includes differing standards of
readability, quite apart from the differences in monitors that make
a Mac user's *red* look more like *orange* to me (and CML2 will be
used, perhaps even more often used, off stock x86 hardware).

Without counting, I estimate that 50% of the problem (I won't say "bug"
in this context) reports you have had since 1.0.0 have been about colors.
The more users you get, the more such complaints there will be.  Nail
this one to the wall before people start demanding contradictory changes.

If you don't have a full X resources parser, then do a trivial scan of
just .Xdefaults and look for a few fixed cases like

	CMLConfigure*YColor: 0xrrbbgg
	CMLConfigure*NColor: 0xrrbbgg

etc. etc.  Or provide a private .rc file.  Or *something*.

-- 
John Cowan                                   cowan@ccil.org
One art/there is/no less/no more/All things/to do/with sparks/galore
	--Douglas Hofstadter
