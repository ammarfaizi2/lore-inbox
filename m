Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSJARkv>; Tue, 1 Oct 2002 13:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262118AbSJARkv>; Tue, 1 Oct 2002 13:40:51 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:20107 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262173AbSJARjd>; Tue, 1 Oct 2002 13:39:33 -0400
Date: Tue, 1 Oct 2002 12:44:47 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
In-Reply-To: <Pine.NEB.4.44.0210011924070.10143-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0210011242310.10307-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Adrian Bunk wrote:

> This change is broken, it has the effect that compilation no longer stops
> when the compilation of a .c file fails, kbuild doesn't stop the
> compilation until it misses the .o when linking, e.g. (the directory is
> still called "2.5.39" because I forgot to change the name after applying
> patch-2.5.40 but this is 2.5.40):

Grrr, you're right, I keep forgetting about this annoying property of 
piping the output. BTW, the patch also has another bug, it shouldn't 
affect the (default) KBUILD_VERBOSE=1 case at all, but it does.

Have to think of a sensible fix.

--Kai

