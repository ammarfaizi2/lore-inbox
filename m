Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRECSiy>; Thu, 3 May 2001 14:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131626AbRECSip>; Thu, 3 May 2001 14:38:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32264 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131497AbRECSib>; Thu, 3 May 2001 14:38:31 -0400
Subject: Re: [kbuild-devel] Why recovering from broken configs is too hard
To: esr@thyrsus.com
Date: Thu, 3 May 2001 19:41:33 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503143037.A1822@thyrsus.com> from "Eric S. Raymond" at May 03, 2001 02:30:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vO2i-00060Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You want brutality and heuristics?  I'll give you brutality and heuristics...
> I could just treat a config as a sequence of assignments, as though
> the user had typed them in sequence, rejecting any later ones that
> throw constraint violations.  That way we can avoid ever accepting or
> having to deal with an invalid configuration.  The invariant that every
> symbol assignment either augments a valid configuration or is rejected
> would be conserved.

Which is pretty much what make oldconfig does. Go from the top asking users
about new symbols and just killing stuff that would break the rules.

> This isn't "recovery", it's more like high-handedly throwing away
> assignments that don't happen to fit stuff bound earlier in the tree
> traverse that defines symbol print order.  And it's going to give odd,
> "brutal" results in some cases because guard symbols are ordered
> before their dependents.

Thats the mathematician speaking again

> But if all you want is brutality and heuristics, it might do.

Its worked well enough for the past five years. On odd occasions you do find
you've inadventantly unconfigured something but normally the conflict vanishes
with almost no ripples.

I'm quite happy for oldconfig to continue to do what it did before. I'm quite
happy to accept its mathematically imperfect, because it hasnt gone far wrong
yet

Alan

