Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292370AbSBPOh4>; Sat, 16 Feb 2002 09:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292371AbSBPOhr>; Sat, 16 Feb 2002 09:37:47 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:50951
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292370AbSBPOhc>; Sat, 16 Feb 2002 09:37:32 -0500
Date: Sat, 16 Feb 2002 09:10:18 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Dave Jones <davej@suse.de>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216091018.I23546@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@mandrakesoft.com>, Dave Jones <davej@suse.de>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C6DE6A1.2B5717BE@mandrakesoft.com> <E16c44r-000670-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16c44r-000670-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Feb 16, 2002 at 12:36:29PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> The graph tells you that. The only interesting case I could find is the
> negation one - some rules are  A conflicts with B which makes the UI side
> much more fun

That's right.  This is a CML2 require/prohibit construct.  CML1 cannot
express this, and it's essential for side-effect forcing to work.  Jeff's
observation about being tempted to introduce a `require' turns out actually 
to be equivalent once you see how both problems generalize.

You can't deduce these constraints from graph analysis, because they're 
not implicit in the if/then tree structure that is the only thing CML1
knows about.

Jeff and Alan have now almost caught up to where I was two years ago when
I realized the CMl1 formalism was inadequate.

This is going in the FAQ.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
