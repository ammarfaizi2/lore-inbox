Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbTALWHT>; Sun, 12 Jan 2003 17:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTALWHT>; Sun, 12 Jan 2003 17:07:19 -0500
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.133]:49339 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267550AbTALWHS>; Sun, 12 Jan 2003 17:07:18 -0500
Date: Sun, 12 Jan 2003 17:12:42 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <32929.62.98.226.220.1042408728.squirrel@webmail.roma2.infn.it>
To: Emiliano Gabrielli <emiliano.gabrielli@roma2.infn.it>
Cc: linux-kernel@vger.kernel.org
Reply-to: robw@optonline.net
Message-id: <1042409562.1209.142.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
 <20030112211530.GP27709@mea-ext.zmailer.org>
 <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
 <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com>
 <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
 <32929.62.98.226.220.1042408728.squirrel@webmail.roma2.infn.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 16:58, Emiliano Gabrielli wrote:
> you do, if you inline the code and every drive writer use this tecnique the kernel will
> be much bigger don't you think ?!?

Kernel size (footprint in memory) would grow a tad bit (not much), but
it's overall speed would also go up.  

> Makeing a simple function instead is quite slower I think... don't forget that goto are
> used only in error recovery routines ...

That wasn't the case in Torvalds' sample code which started this
thread.  That was spin-locking code, I believe.  Of course, in that
case, there was no need for an inline function or anything, but rather
restructuring of an if statement.

> You can simply build a "stack" of labels .. IMHO this is a great way to be sure of the
> right order we are performing cleanup/recovery ...

If the kernel developer "knows" always that they have to follow the
stack order when adding additional cases, it's fine.  But it is more
obvious in the patch I wrote what is going on than in the original
"goto" version of the code with the fs/open.c code someone asked me to
look at.  This makes it harder for people unfamiliar with the complete
linux kernel design in this area to get started.  Of course, I'm getting
a crash course it seems.

-Rob

