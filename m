Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSJHQPd>; Tue, 8 Oct 2002 12:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261362AbSJHQPR>; Tue, 8 Oct 2002 12:15:17 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:8327 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261356AbSJHQO7>; Tue, 8 Oct 2002 12:14:59 -0400
Date: Tue, 8 Oct 2002 11:19:34 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Adrian Bunk <bunk@fs.tum.de>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
       Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.41-ac1 
In-Reply-To: <Pine.NEB.4.44.0210081804260.8340-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0210081116180.32256-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Adrian Bunk wrote:

> On Tue, 8 Oct 2002, Kai Germaschewski wrote:
> 
> >...
> > To restore the previous state, just do
> >
> > obj-y += ... ../kernel/trampoline.o
> >...
> 
> There seems to be a bug in kbuild that makes your suggestion impossible:

Oh well, actually, I only made it possible to have multipart objects pull 
in objects from different dirs (but I still discourage that except for 
special cases), not for obj-y.

So you have to do sth like

obj-y += .. trampoline.o

trampoline-objs := ../kernel/trampoline.o

And you do not really want to do this, you rather want CONFIG_VOYAGER to 
define_bool CONFIG_X86_SMP y and be done without ugly hacks in the 
Makefiles.

--Kai


