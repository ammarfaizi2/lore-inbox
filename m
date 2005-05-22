Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVEVHZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVEVHZz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 03:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVEVHZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 03:25:55 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:19352 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261764AbVEVHZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 03:25:48 -0400
Date: Sun, 22 May 2005 09:28:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kedar Sovani <kedars@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kbuild trick
Message-ID: <20050522072813.GA16814@mars.ravnborg.org>
References: <20050517201148.GA12997@64m.dyndns.org> <428B4C67.5090307@ammasso.com> <20050518123854.GA13452@64m.dyndns.org> <428B646C.3030501@ammasso.com> <20050518132417.GA14488@64m.dyndns.org> <428B7143.4090607@ammasso.com> <20050518182250.GB8130@mars.ravnborg.org> <428B8809.8060406@ammasso.com> <20050520193706.GA8225@mars.ravnborg.org> <5edf7fc905052103593ea75abf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5edf7fc905052103593ea75abf@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2005 at 04:29:35PM +0530, Kedar Sovani wrote:
> One of the question that I haven't yet managed to solve properly is
> how do we manage kernel modules which have its C files in multiple
> underlying directories.
> 
> say :
> /src/Makefile
> /src/main.c
> /src/module1/Makefile
> /src/module1/module1.c
> /src/module1/module_stuff.c
> 
> And the 3 C files should be built into a single module at the top level.
> I tried something like this in the top level Makefile, but it does not work.
> 
> obj-m += mymodule.o
> main-objs=main.o module1/

This create a number of modules - sometimes a good way to do it.
We have several examples in the kernel using this method.

> 
> I could use,
> main-objs=main.o module1/module1.o module1/module_stuff.o
> 
> But I don't think that is a good idea. I looked at
> Documentation/kbuild/, but no luck.
This is one way to do it.
The other way as used by the kernel is to avoid spreading the .c
files in multiple directories.

	Sam
