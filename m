Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132373AbRCZHXV>; Mon, 26 Mar 2001 02:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132372AbRCZHXM>; Mon, 26 Mar 2001 02:23:12 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:50962 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132371AbRCZHWy>; Mon, 26 Mar 2001 02:22:54 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15038.60956.18563.327332@wire.cadcamlab.org>
Date: Mon, 26 Mar 2001 01:22:04 -0600 (CST)
To: Eric Raymond <esr@snark.thyrsus.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch
In-Reply-To: <200103260001.f2Q01Yt09387@snark.thyrsus.com>
	<15038.56527.591553.87791@wire.cadcamlab.org>
	<3ABEE0B5.12A2F768@mandrakesoft.com>
	<20010326014913.B11181@thyrsus.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Jeff Garzik]
> > It stays "8139too".  Donald Becker's rtl8139.c continues to exist
> > outside the kernel.

Honestly, Jeff, I don't see how it matters -- because if you are
downloading an external driver, you are not going through the config
system anyway.

But ... "maintanicus selector est" (my pseudo-Latin for "the maintainer
gets to choose") so I support your stand.

[esr]
> Now, wait, Jeff.  I'm not attached to Peter's change, but I don't
> think we can reasonably be expected to worry about every possible
> driver left over from every old version of Linux when managing the
> configuration-symbol namespace.  That way madness lies.

Eric, the issue arose because you are obliquely proposing -- nay,
insisting on -- a policy change.  CONFIG_8139TOO is a perfectly valid
preprocessor token and a perfectly valid GNU Make macro name.  It
corresponds with a source file '8139too.c' which is also perfectly
valid.

Did it never occur to you that by insisting on a policy change (and
related code changes), with no discussion, consensus or mandate, and
which fixes no current bugs ... that a few toes may feel stepped on?

The burden of proof is yours.  Why should a CML2 design decision
(stripping of CONFIG_ in the configuration files) change what seems to
be an entirely reasonable policy?  Especially since there are multiple
ways, which you have rejected, to work around the lexical problem in
CML2 itself?

Peter
