Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132349AbRCZGql>; Mon, 26 Mar 2001 01:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132350AbRCZGqb>; Mon, 26 Mar 2001 01:46:31 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:52997 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132349AbRCZGqM>;
	Mon, 26 Mar 2001 01:46:12 -0500
Date: Mon, 26 Mar 2001 01:49:13 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Peter Samuelson <peter@cadcamlab.org>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch
Message-ID: <20010326014913.B11181@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Peter Samuelson <peter@cadcamlab.org>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200103260001.f2Q01Yt09387@snark.thyrsus.com> <15038.56527.591553.87791@wire.cadcamlab.org> <3ABEE0B5.12A2F768@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ABEE0B5.12A2F768@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Mar 26, 2001 at 01:24:53AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com>:
> > The -TOO suffix was to distinguish between this and the former 8139
> > driver, as the two coexisted in 2.2 and 2.3.  As the old driver has
> > been dropped from 2.4, I propose likewise dropping the -TOO.
> 
> It stays "8139too".  Donald Becker's rtl8139.c continues to exist
> outside the kernel.  
> 
> And "rtl8139too" should have never crept into 2.2.  That needs to be
> changed to "8139too."  That's what I get for saying that I don't support
> 2.2...

Now, wait, Jeff.  I'm not attached to Peter's change, but I don't think
we can reasonably be expected to worry about every possible driver
left over from every old version of Linux when managing the
configuration-symbol namespace.  That way madness lies.

I'll cheerfully ship a supplementary patch to fix this one name later,
but we can't afford to have a wrangle over this bit of trivia delay
adoption of this one.  I have a hell of a lot of work to do for
which this is critical path.  

I left it pretty late as it is, out of hope that other people would
clean up some of the messes I noticed in the config namespace six
months ago, and they did -- but the 2.5 fork is nearly upon us and I
feel a strong need to get this in before then.

Would you and Peter please fight this out and tell me what to do in the
supplementary patch?  I don't care, as long as the result has a non-numeric
prefix -- bare "8139whatever" is out.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Sometimes it is said that man cannot be trusted with the government
of himself.  Can he, then, be trusted with the government of others?
	-- Thomas Jefferson, in his 1801 inaugural address
