Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUI0Qhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUI0Qhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUI0QfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:35:22 -0400
Received: from linaeum.absolutedigital.net ([63.87.232.45]:4029 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S266768AbUI0Qe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:34:58 -0400
Date: Mon, 27 Sep 2004 12:34:48 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Matthew Wilcox <matthew@wil.cx>, Matthew Wilcox <willy@debian.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make make install install modules too
In-Reply-To: <Pine.LNX.4.61.0409271413350.20693@jjulnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.60.0409271225370.23044@linaeum.absolutedigital.net>
References: <20040917170051.GU642@parcelfarce.linux.theplanet.co.uk>
 <20040927072246.GA8613@mars.ravnborg.org> <20040927113727.GQ16153@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.61.0409271413350.20693@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004, Jesper Juhl wrote:

> > > On Fri, Sep 17, 2004 at 06:00:51PM +0100, Matthew Wilcox wrote:
> > > > 
> > > > I keep forgetting to run 'make modules_install' after make install.  Since
> > > > make now compiles modules too and there's no separate make modules step,
> > > > it seems to make sense that make install should also install modules.
> > > 
> 
> And how about people who, for some reason, don't want the modules 
> installed?
> Sure, you can just copy the files you want by hand, which is what I do 
> personally, but I find it nice that installing the kernel image and 
> modules are two sepperate steps. If a user wants both done automagically, 
> then that user could just create a 2 line shell script.

indeed, this should do what you want

$ cat ~/bin/installkernel

#!/bin/sh

cp .config /boot/config-$1
cp $3 /boot/System.map-$1
cp $2 /boot/vmlinuz-$1
make modules_install

-- Cal

