Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132765AbRDDIK0>; Wed, 4 Apr 2001 04:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132767AbRDDIKR>; Wed, 4 Apr 2001 04:10:17 -0400
Received: from 13dyn214.delft.casema.net ([212.64.76.214]:48913 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132765AbRDDIKD>; Wed, 4 Apr 2001 04:10:03 -0400
Message-Id: <200104040808.KAA27469@cave.bitwizard.nl>
Subject: Re: Larger dev_t
In-Reply-To: <E14kQ55-0007zD-00@the-village.bc.nu> from Alan Cox at "Apr 3, 2001
 01:38:40 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 4 Apr 2001 10:08:51 +0200 (MEST)
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > What's worth it to be able running 2.0 and 2.4 on the same box?
> > I just intendid to tell you that there are actually people in the
> > REAL BUSINESS out there who know about and are willing to sacifier
> > compatibility until perpetuum for contignouus developement.
 
> And many people who require the ability to drop back one or two
> versions (major versions) on a problem. Every upgrade requires a
> getout path

Right. So if we go to 64 bits NOW (in 2.4), then when after 3.2 we
actually start needing > 16 bits of dev_t everyone can downgrade to
2.0, except those people who use drivers that require those extra
bits.

The further away from "the deadline" that we switch, the easier it
becomes to provide a smooth upgrade path. When we have 65536 devices
in use, when we finally switch, you can bet your ass we'll be using
the "new" device number space right away. However, if we're still
comfortable with the 16 bits, we can upgrade the infrastructure ASAP,
and make the "no return" switch later. Much later.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
