Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbTBQENc>; Sun, 16 Feb 2003 23:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbTBQENc>; Sun, 16 Feb 2003 23:13:32 -0500
Received: from dp.samba.org ([66.70.73.150]:17385 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266771AbTBQENc>;
	Sun, 16 Feb 2003 23:13:32 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Brian Gerst <bgerst@didntduck.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move __this_module to xxx.mod.c 
In-reply-to: Your message of "Sun, 16 Feb 2003 19:57:04 MDT."
             <Pine.LNX.4.44.0302161946220.5217-100000@chaos.physics.uiowa.edu> 
Date: Mon, 17 Feb 2003 14:42:40 +1100
Message-Id: <20030217042330.D50DE2C04D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302161946220.5217-100000@chaos.physics.uiowa.edu> yo
u write:
> On Sun, 16 Feb 2003, Brian Gerst wrote:
> 
> > This patch moves the module structure to the generated .mod.c file, 
> > instead of compiling it into each object and relying on the linker to 
> > include it only once.
> 
> Yeah, it's something I though about doing, but I was not sure. I think 
> it's up to Rusty to comment ;)
> 
> It will need an associated change to module_init_tools.

I don't think so: the symbol will be in the module by the time
module-init-tools gets to it, or am I missing something?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
