Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSGTBUm>; Fri, 19 Jul 2002 21:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSGTBUl>; Fri, 19 Jul 2002 21:20:41 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:17280 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317302AbSGTBUk>; Fri, 19 Jul 2002 21:20:40 -0400
Date: Fri, 19 Jul 2002 20:23:36 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: John Levon <movement@marcelothewonderpenguin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild - building a module/target from multiple directories
In-Reply-To: <20020720002521.GA34954@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0207192019230.1639-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002, John Levon wrote:

> With kbuild in 2.5, how do I specify that a module/target is to be built of
> object files and sub-directories ?

Short answer: Don't.

> The "obvious" approach :
> 
> obj-$(CONFIG_BLAH) := blah.o
> 
> blah-objs := blah_init.o blahstuff/
> 
> doesn't work. Is there an example of a module doing this ?

Well, first of all I'd rather discourage doing so in general. However, XFS 
is split into subdirs, so you could probably take a look at their latest 
CVS to see how it's done.

Basically, use only one Makefile and

	blah-objs := blah_init.o blahstuff/blah1.o blahstuff/blah2.o ...

in there.

--Kai


