Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSHNUBo>; Wed, 14 Aug 2002 16:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319274AbSHNUBo>; Wed, 14 Aug 2002 16:01:44 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:50437 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S315491AbSHNUBn>;
	Wed, 14 Aug 2002 16:01:43 -0400
Date: Wed, 14 Aug 2002 22:14:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, Greg Banks <gnb@alphalink.com.au>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Get rid of shell based Config.in parsers?
Message-ID: <20020814221400.A1562@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Greg Banks <gnb@alphalink.com.au>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu> <20020808164742.GA5780@cadcamlab.org> <20020809041543.GA4818@cadcamlab.org> <3D53D50D.7FA48644@alphalink.com.au> <20020809161046.GB687@cadcamlab.org> <3D579629.32732A73@alphalink.com.au> <20020812154721.GA761@cadcamlab.org> <3D587BA7.1D640926@alphalink.com.au> <20020813180415.B1357@mars.ravnborg.org> <3D59A2DF.3DDA38E8@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D59A2DF.3DDA38E8@alphalink.com.au>; from gnb@alphalink.com.au on Wed, Aug 14, 2002 at 10:22:55AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 10:22:55AM +1000, Greg Banks wrote:
> The trouble is actually achieving that in shell-based parsers where
> shell code cannot tell whether $CONFIG_EXPERIMENTAL has been used in
> a condition.

Where comes the requirement that we shall keep the existing shell 
based config parsers?

Remembering the CML2 war there were no serious objections about
shifting away from shell based parsers (but certainly a lot about the
alternative selected).

It is possible to replace Configure and menuconfig rather easy
and then see if a new xconfig showed up based on the new parsers.
This would allow us to do much more advanced semantic checks, and
give proper warnings to catch errors early.
The first versions should obviously not introduce new syntax, that
should evolve over time.


I dislike seeing arguments that this is not easy/possible in shell based
parsers. If the chosen technology does not fit the problem domain
then it's about time to shift technology.

	Sam
