Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTKROOa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 09:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbTKROOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 09:14:30 -0500
Received: from gaia.cela.pl ([213.134.162.11]:32517 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263667AbTKROO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 09:14:28 -0500
Date: Tue, 18 Nov 2003 15:14:01 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Pontus Fuchs <pof@users.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Announce: ndiswrapper
In-Reply-To: <3FBA25CD.5020708@pobox.com>
Message-ID: <Pine.LNX.4.44.0311181510290.29639-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pontus Fuchs wrote:
> > Please! I don't want to start a flamewar if this is a good thing to do.
> > I'm just trying to scratch my own itch and I doubt that this project
> > changes the way Broadcom treats Linux users.
> 
> 
> Then help us reverse engineer the driver :)
> 
> 	Jeff

In a way getting it to run under linux (in an pseudo-ndis-emu box) is part
of getting it reverse engineered - then we set up io-trace and presto we
know precisely what is going on ;)

Speaking of io-trace has anyone actually done this?  I'm working on a 
strace patch for io-trace'ing of user processes and have come to the 
conclusion that this should be at least partially done in kernel-space 
(you can't attach/detach to a pid without kernel support, you can io-trace 
a program from start to finish in pure userspace, but as soon as you want 
to attach to a running Xserver you are basically screwed (although that 
can be circumvened), however if you want to detach then you are screwed 
totally (unless you like live auto-patching of the traced program)...

I'm thinking of rewriteing the patch into the kernel ptrace mechanism 
(i.e. PTRACE_IO_SYSCALL - stop on IO operations or syscalls)

Cheers,
MaZe.

