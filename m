Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132378AbRCZHiL>; Mon, 26 Mar 2001 02:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132379AbRCZHiB>; Mon, 26 Mar 2001 02:38:01 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:64005 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132378AbRCZHhw>;
	Mon, 26 Mar 2001 02:37:52 -0500
Date: Mon, 26 Mar 2001 02:40:52 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Eric Raymond <esr@snark.thyrsus.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch
Message-ID: <20010326024052.C12481@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Peter Samuelson <peter@cadcamlab.org>,
	Eric Raymond <esr@snark.thyrsus.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200103260001.f2Q01Yt09387@snark.thyrsus.com> <15038.56527.591553.87791@wire.cadcamlab.org> <3ABEE0B5.12A2F768@mandrakesoft.com> <20010326014913.B11181@thyrsus.com> <15038.60956.18563.327332@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15038.60956.18563.327332@wire.cadcamlab.org>; from peter@cadcamlab.org on Mon, Mar 26, 2001 at 01:22:04AM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson <peter@cadcamlab.org>:
> 
>   [Jeff Garzik]
> > > It stays "8139too".  Donald Becker's rtl8139.c continues to exist
> > > outside the kernel.
> 
> Honestly, Jeff, I don't see how it matters -- because if you are
> downloading an external driver, you are not going through the config
> system anyway.
> 
> But ... "maintanicus selector est" (my pseudo-Latin for "the maintainer
> gets to choose") so I support your stand.

And that's an argument I can buy, too.  I'll restore the TOO prefix
in my change list.
 
> Eric, the issue arose because you are obliquely proposing -- nay,
> insisting on -- a policy change.  CONFIG_8139TOO is a perfectly valid
> preprocessor token and a perfectly valid GNU Make macro name.  It
> corresponds with a source file '8139too.c' which is also perfectly
> valid.
> 
> Did it never occur to you that by insisting on a policy change (and
> related code changes), with no discussion, consensus or mandate, and
> which fixes no current bugs ... that a few toes may feel stepped on?

Actually, that's not what I did.  One of the principal PPC maintainers
agreed to get the PPC numeric-prefix symbols (9 of the 20) cleaned up,
but dropped the ball.  I waited on this as long as I thought I could.

> The burden of proof is yours.  Why should a CML2 design decision
> (stripping of CONFIG_ in the configuration files) change what seems to
> be an entirely reasonable policy?  Especially since there are multiple
> ways, which you have rejected, to work around the lexical problem in
> CML2 itself?

The workarounds would be slow, or ugly, or both.  As I said -- I might
have gone with them, but there since had to be a fix patch anyway, and
I had buy-in for all but 11 of the 39 changes...
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

According to the National Crime Survey administered by the Bureau of
the Census and the National Institute of Justice, it was found that
only 12 percent of those who use a gun to resist assault are injured,
as are 17 percent of those who use a gun to resist robbery. These
percentages are 27 and 25 percent, respectively, if they passively
comply with the felon's demands. Three times as many were injured if
they used other means of resistance.
        -- G. Kleck, "Policy Lessons from Recent Gun Control Research,"
