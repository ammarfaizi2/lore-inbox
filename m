Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbTAEHuL>; Sun, 5 Jan 2003 02:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbTAEHuL>; Sun, 5 Jan 2003 02:50:11 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:4358 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263544AbTAEHuK>;
	Sun, 5 Jan 2003 02:50:10 -0500
Date: Sun, 5 Jan 2003 08:58:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jochen Friedrich <jochen@scram.de>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Andreas Dilger <adilger@turbolabs.com>, Larry McVoy <lm@bitmover.com>
Subject: Re: Documentation/BK-usage/bksend problems?
Message-ID: <20030105075842.GA1256@mars.ravnborg.org>
Mail-Followup-To: Jochen Friedrich <jochen@scram.de>,
	Matthias Andree <matthias.andree@gmx.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Andreas Dilger <adilger@turbolabs.com>, Larry McVoy <lm@bitmover.com>
References: <20030105015444.GE29511@merlin.emma.line.org> <Pine.LNX.4.44.0301050839340.19683-100000@gfrw1044.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301050839340.19683-100000@gfrw1044.bocc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 08:42:59AM +0100, Jochen Friedrich wrote:
> Hi Matthias,
> 
> > The changes are fine, for 1.838 and 1.839, but the patch itself only
> > contains the effects of 1.839. The attached gzip_uu wrapped bk
> > "receive"able stuff is fine again and contains both ChangeSets.
> >
> > It seems as though it would take "diff 1.839 against 1.838" for bk gnupatch
> > and "changesets 1.838 to 1.839 inclusively" for bk send.
> 
> I noticed the same when sending my Token Ring updates. Here i tried to
> send 4 changesets and only the second one ended up in the patch while the
> bk send part was OK. This was on Alpha, so i don't think it's arch
> dependent.

I have seen something similar.

bk export -tpatch -r1.984..1.985
only exports cset 1.985

bk export -tpatch -r1.984
exports cset 1.984 as expected.

bk export -tpatch -r1.983..1.985
will export cset 1.984+1.985.

BK Version:
BitKeeper version is bk-3.0 20021011025136 for x86-glibc22-linux
Built by: lm@redhat71.bitmover.com in /build/bk-3.0-lm/src
Built on: Thu Oct 10 20:33:13 PDT 2002

I will submit this with bk sendbug now.

	Sam
