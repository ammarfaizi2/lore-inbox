Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSKRQap>; Mon, 18 Nov 2002 11:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSKRQap>; Mon, 18 Nov 2002 11:30:45 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:12701 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262924AbSKRQao>; Mon, 18 Nov 2002 11:30:44 -0500
Date: Mon, 18 Nov 2002 10:36:20 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Bill Davidsen <davidsen@tmr.com>
cc: Sam Ravnborg <sam@ravnborg.org>, Nicolas Pitre <nico@cam.org>,
       Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
In-Reply-To: <Pine.LNX.3.96.1021117024753.18748B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0211181034100.24137-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Nov 2002, Bill Davidsen wrote:

> On Fri, 15 Nov 2002, Sam Ravnborg wrote:
> 
> > Here is first try:
> > - clean now deletes all generated files except .config + .config.old
> > - mrproper in addition to clean only deleted .config + .config.old
> > - distclean in addition ot mrproper deletes backupfiles as usual.
> 
> Just what I wanted. If you can be happy doing this it now provides all
> three useful behaviours in a clear manner.

But when do you need the "clean + rm .config*" behavior? I don't see that 
to be such a common case.

That's why I think two targets are enough, "clean" to remove the files
generated during the build and "distclean" to remove all other extra stuff
to. And just keep mrproper to be an alias for distclean, since that's what
"mrproper" traditionally was (AFAIK, Linus used it that way).

--Kai


