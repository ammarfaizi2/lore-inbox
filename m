Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132359AbRCZHGV>; Mon, 26 Mar 2001 02:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132358AbRCZHGM>; Mon, 26 Mar 2001 02:06:12 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:55045 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132357AbRCZHGF>;
	Mon, 26 Mar 2001 02:06:05 -0500
Date: Mon, 26 Mar 2001 02:09:02 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch
Message-ID: <20010326020902.C11181@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <200103260001.f2Q01Yt09387@snark.thyrsus.com> <15038.56527.591553.87791@wire.cadcamlab.org> <3ABEE0B5.12A2F768@mandrakesoft.com> <3ABEE4C0.36EB75F5@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ABEE4C0.36EB75F5@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Mar 26, 2001 at 01:42:08AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com>:
> FWIW I am opposed to any large-scale cleanup of the configuration
> language and/or identifiers in -any- 2.4.x series kernel.

This is tweaking 39 symbols out of 1831, hardly large-scale.  These
irregularities in the namespace cause trouble out of all proportion to
their size, is my problem.  If you knew what I've been through trying
to write analysis tools...*shudder*...
 
> Not only C code but installer utilities are affected by changes in the
> CONFIG_xxx identifiers.  If we change that namespace, we are changing
> part of the API that is exported to drivers.  Definitely not 2.4.x
> stuff.

My patch fixes those installer utilities.  All three of them.  And no driver
code is or possibly could be broken by it, that's a red herring.  *No
object code will change as a result of this patch*.
 
> If we are moving to CML2 in 2.5, I see no point in big CML1 cleanups.

Yes, I know, that's what I said about Peter's DERIVED patch a week ago.
You notice *he* ain't bitching about this one?

I want this in before the 2.5 fork for several reasons:

(1) 19 of the 39 changes fix things that are outright bugs even in CML1.
    These should not be allowed to persist in the stable branch.

(2) I want to finish my analysis tools and do some really thorough
    consistency and correctness checking before the stable branch
    separates.  Alan will thank me for this later.

(2) If we do adopt CML2, having these changes in will make it *far* 
    easier to contemplate back-porting it to 2.4.x later on.

The present configuration system is a mess, everybody agrees on that.
I'm trying to clean it up, and it's a tedious and grubby enough job
even with the full cooperation of the kbuild team.  Jeff, would you
please support this instead of obstructing it?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

  "You have taught us much. Come with us and join the movement."
  "This movement of yours, does it have slogans?" inquired the Chink.
  "Right on!" they cried. And they quoted him some.
  "Your movement, does it have a flag?" asked the Chink.
  "You bet!" and they described their emblem.
  "And does your movement have leaders?"
  "Great leaders."
  "Then shove it up your butts," said the Chink. "I have taught you nothing."

	-- Tom Robbins, "Even Cowgirls Get The Blues"
