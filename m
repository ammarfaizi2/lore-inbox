Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292270AbSBOXZp>; Fri, 15 Feb 2002 18:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292271AbSBOXZh>; Fri, 15 Feb 2002 18:25:37 -0500
Received: from femail38.sdc1.sfba.home.com ([24.254.60.32]:49623 "EHLO
	femail38.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S292270AbSBOXZU>; Fri, 15 Feb 2002 18:25:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: esr@thyrsus.com, Dave Jones <davej@suse.de>,
        Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Date: Fri, 15 Feb 2002 18:26:06 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020215135557.B10961@thyrsus.com> <20020215224916.L27880@suse.de> <20020215170459.A15406@thyrsus.com>
In-Reply-To: <20020215170459.A15406@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020215232517.FXLQ71.femail38.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 February 2002 05:04 pm, Eric S. Raymond wrote:

> Solutions that involve me doing an arbitrary and increasing amount of
> hand-hacking on every release are right out.

Um, Eric?  Isn't that what being a maintainer basically means?

Okay, Linus's changes killed backwards compatability with 2.4.  (He does 
that.  That's what 2.5 is for.  It would be nice if less of it happened in 
the stable series, but... :)

A maintainer is basically there to serve Linus (the project's undisputed 
architect), who periodically makes the architectural decision to break 
backwards compatability on some front.

You wanted to remain 2.4 help file maintainer as well as 2.5, and Linus did 
not address this concern (for whatever reason: Linus blackholing email as a 
way of disagreeing with it led to a lot of miscommunications like this one.)  
Fine.  Water under the bridge.  Linus made an architectural decision, and it 
has been implemented.  If it means you can't maintain 2.4 anymore, the sane 
move is to drop 2.4 (which you did) and move on.

That is why this is a dead issue, and bringing it up again doesn't serve as 
much purpose as you think it does.  (If you want to highlight the 
blackhole-related miscommunication, fine.  But even implying Linus's 
architectural decision was wrong carries no weight with your audience.)

> If you think this problem through, I'm sure you'll come up with a
> design very similar to what I actually built.  Which, by Linus's
> choice, got irrecoverably nuked.

Tough.

Eric, I like you and I still don't agree with you on this one.

First of all, the help files really are largely orthogonal to CML2.  They 
could be written in gzipped ebcdic.  Make a filter, read them, move on.  You 
are pointelessly wasting brownie points on a dead side issue.

Secondly, please define the problem space you're going after.  (I think that 
the main objection people have to this tool, they don't agree with the 
definition of the problem you're trying to solve.)

If you want CML2 is to be the best configure tool for the 2.5 (and later) 
kernel series, fine.  Then FOCUS ON THAT PROBLEM.

Overhead to deal with 2.4 is bloat.  Flexibility for projects outside of the 
kernel itself is a side issue.  Aunt Tillie is NOT the initial target 
audience.  Usage to configure debian userspace or some such is completely 
tangential.  All of the above may be fun, but they do not serve to advance 
the primary objective, and bringing them up does not help make a case for 
CML2.

Back up a bit.  What would be the most minimal, stripped-down version of CML2 
you could write?  No eye candy, no complications, no autoconfigurator, no 
tree view, no frozen symbols.  Just solving the core problem of configuring 
2.5 in a more flexible and less buggy way than CML1, with the three 
interfaces (oldconfig, menuconfig, xconfig) we've got now.

Think about that for a while.  Try to get THAT into the kernel.  THEN worry 
about building on top of that.

Remember: Linus likes small patches.  (CONCEPTUALLY small if possible, not 
just lines of code...)

Rob
