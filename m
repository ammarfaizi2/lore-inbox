Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264642AbSJTUeF>; Sun, 20 Oct 2002 16:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264643AbSJTUeE>; Sun, 20 Oct 2002 16:34:04 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:45238 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264642AbSJTUeE>;
	Sun, 20 Oct 2002 16:34:04 -0400
Date: Sun, 20 Oct 2002 22:36:22 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210202036.WAA25188@harpo.it.uu.se>
To: sam@ravnborg.org
Subject: Re: [PATCH] 2.5.44 mrproper removes editor backup files
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002 20:27:18 +0200, Sam Ravnborg wrote:
> On Sun, Oct 20, 2002 at 08:01:54PM +0200, Mikael Pettersson wrote:
> > Contrary to years of history and several explicit comments in
> > Makefile that mrproper != distclean, 2.5.44 merged the two
> > which causes mrproper to incorrectly remove editor backup files.
> 
> Why do you need three levels of cleaning?
> In other words what is it that make clean failed to clean in your case.

I only use mrproper myself. Always have. Over the years I've seen
too many build failures for others caused by insufficient cleaning
to really trust plain clean.

> I know that we always used to say: make mrproper can cure everything.
> But make clean starts to get the power of make mrproper.

> It makes sense to kill one of them, but make help needs an update though.
> You could argue if distclean=mrproper or mrproper=clean.

Changing the behaviour of mrproper is like $EDITOR suddenly changing its
core key bindings. Users accustomed to those bindings won't be happy.

If, for whatever reason, clean becomes as powerful as mrproper, just
set mrproper == clean. Or remove clean but keep mrproper :-)

/Mikael
