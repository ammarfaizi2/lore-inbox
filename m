Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTETOe3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 10:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbTETOe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 10:34:29 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:14765 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S263800AbTETOe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 10:34:27 -0400
Date: Tue, 20 May 2003 09:47:22 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Brian Gerst <bgerst@didntduck.org>
cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update fs Makefiles
In-Reply-To: <3EC952E9.9080201@quark.didntduck.org>
Message-ID: <Pine.LNX.4.44.0305200940130.24017-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, Brian Gerst wrote:

> Sam Ravnborg wrote:
> > On Sun, May 18, 2003 at 08:51:09PM -0400, Brian Gerst wrote:
> > 
> >>Convert foo-objs to newer-style foo-y.
> > 
> > 
> > The paths looks correct.
> > But do we really want to go that far, and deprecate the -objs syntax?
> > 
> > 
> >>-adfs-objs := dir.o dir_f.o dir_fplus.o file.o inode.o map.o super.o
> >>+adfs-y := dir.o dir_f.o dir_fplus.o file.o inode.o map.o super.o
> > 
> > 
> > The patch contains a lot of changes like the above - and they
> > are only relevant if we deprecate the -objs syntax.
> 
> Why have two methods of doing the same thing?  foo-y is clearly the 
> preferred method because it is easy to work with conditionals.

I tend to agree, though I don't feel strongly about it. Having two 
different methods of expressing the same thing will always be confusing. 

OTOH, 2.4 does only support "-objs", so people may get confused anyway, 
and annoyed about having two different Makefiles to maintain in 2.4 and 
2.5. Then again, the Makefiles between 2.4 and 2.5 have other differences 
already, and since they're small and rarely changing, maintaining two sets 
isn't so much of a pain.

So I would suggest:
o Change "-objs" to "-y" in 2.5
o Warn / error about the deprecated use in 2.5 when "-objs" is 
  encountered.
o Possibly add "-y" support to 2.4 (it's a pretty trivial change)

Ok?

--Kai


