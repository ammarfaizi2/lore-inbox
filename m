Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261519AbSIXBYp>; Mon, 23 Sep 2002 21:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbSIXBYp>; Mon, 23 Sep 2002 21:24:45 -0400
Received: from mnh-1-11.mv.com ([207.22.10.43]:30982 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S261519AbSIXBYo>;
	Mon, 23 Sep 2002 21:24:44 -0400
Message-Id: <200209240234.VAA06026@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: UML kbuild patch 
In-Reply-To: Your message of "Mon, 23 Sep 2002 19:24:01 EST."
             <Pine.LNX.4.44.0209231913060.13892-100000@chaos.physics.uiowa.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Sep 2002 21:34:20 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kai@tp1.ruhr-uni-bochum.de said:
> The actual executable UML generates is called "linux" anyway, so its
> Makefile can have its own rule (as for other archs the boot images)
> which  builds "linux" from "vmlinux" using gcc and the link script. -
> I.e. the  same way as UML used to do it earlier, anyway. 

I'd actually prefer the one-stage link.  That takes better advantage of
the infrastructure that you've put in place.

Instead of making LDFLAGS_vmlinux available to the arch Makefile, can
you make cmd_link_vmlinux available?  Then I can just rewrite it.

That looks like it has no impact on the global Makefile except for moving
it above the include of the arch Makefile.

				Jeff

