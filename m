Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbRCGOno>; Wed, 7 Mar 2001 09:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129564AbRCGOnf>; Wed, 7 Mar 2001 09:43:35 -0500
Received: from ns.caldera.de ([212.34.180.1]:41746 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129185AbRCGOn3>;
	Wed, 7 Mar 2001 09:43:29 -0500
Date: Wed, 7 Mar 2001 15:42:19 +0100
Message-Id: <200103071442.PAA14348@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: gibbs@scsiguy.com ("Justin T. Gibbs")
Cc: linux-kernel@vger.kernel.org
Subject: Re: yacc dependency of aic7xxx driver
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <200103071406.f27E6pO25638@aslan.scsiguy.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200103071406.f27E6pO25638@aslan.scsiguy.com> you wrote:
> The assembler makefile doesn't reference yacc, but instead relies
> on gmake's built in rules to figure out how to generate a .c from
> a .y.  I'm somewhat surprised that bison doesn't create a link to
> yacc or that gmake doesn't try to look for bison.

Yepp, gmake is kindof stupid in that respect - it does also not try
to use flex if there is no lex, etc...  I'd really vote for a BSDish
sys.mk.

> Oh well.  We'll just have to be more careful in how future patches
> are generated so that the dependency between the generated firmware
> files and the firmware source only triggers if you are actually
> performing firmware development.  Trying to build this simple
> assmebler on everyone's systems is turning out to be just too
> hard.

What about simply removing the firmware source and assembler from the
kernel tree?  We have lots of firmware in the kernel tree for which
there isn't even firmware  avaible...

The few people that want to do firware development could download it
from your ftp site.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
