Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269074AbTBXCGE>; Sun, 23 Feb 2003 21:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269075AbTBXCGE>; Sun, 23 Feb 2003 21:06:04 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:49363 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S269074AbTBXCGC>; Sun, 23 Feb 2003 21:06:02 -0500
Date: Sun, 23 Feb 2003 20:16:10 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Pete Zaitcev <zaitcev@redhat.com>
cc: sparclinux@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: State of sparc32 union
In-Reply-To: <20030223202233.A20072@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0302232012050.850-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003, Pete Zaitcev wrote:

> -- The problem is that top Makefile says:
> #       That's our default target when none is given on the command line
> all:    vmlinux

You can just add 

	all: image

to arch/sparc/Makefile - i386 makes bzImage the default target this way.

> <kai> zaitcev: I had a new EXPORT_SYMBOL_DOT() for sparc. But since we 
just blindly skip '.' now for ppc64, it's not necessary, the 
EXPORT_SYMBOL() works.

Bug me some time to dig that out again - ppc64 doesn't need it anymore, 
but for sparc it's the right thing to do.

--Kai


