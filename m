Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTI1TpT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 15:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTI1TpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 15:45:19 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:25272 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262695AbTI1TpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 15:45:13 -0400
Date: Sun, 28 Sep 2003 21:44:31 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030928194431.GB16921@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928193150.GA3074@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030928193150.GA3074@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 September 2003 21:31:50 +0200, Sam Ravnborg wrote:
> On Sun, Sep 28, 2003 at 09:16:22PM +0200, Jörn Engel wrote:
> > How about a check_headers target that roughly works like this:
> > 
> > for (all header files in include/linux and include/asm) {
> > 	echo "#include <$HEADER>" > header.c
> > 	make header.o
> > 	rm header.c header.o
> > }
> 
> That should do it. Can you also integrate the check Linus mentioned,
> to make sure no declarations are present.

If it's simple enough, you'll have it tomorrow.  Linus' check might
take a bit longer, I'm not sure yet how to define an empty object
file.  Is it enough if objdump -tT only shows sections?

> I would name the target: headercheck:
> to be consistent with the other targets.

ok.

> It should be fine having it as a separate target, then we can ask
> John Cherry to include it in his nightly builds.

That would be nice, yes.

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike
