Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261720AbSJMUmi>; Sun, 13 Oct 2002 16:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbSJMUmF>; Sun, 13 Oct 2002 16:42:05 -0400
Received: from goose.mail.pas.earthlink.net ([207.217.120.18]:16311 "EHLO
	goose.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S261679AbSJMUlW>; Sun, 13 Oct 2002 16:41:22 -0400
Date: Sun, 13 Oct 2002 13:40:50 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Anton Blanchard <anton@samba.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [BK PATCH] console changes 1
In-Reply-To: <20021012014332.GA7050@krispykreme>
Message-ID: <Pine.LNX.4.33.0210131338400.6800-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 12 Oct 2002, Anton Blanchard wrote:

>
> > Are you going to have early console support (ie printk from before
> > what is now console_init) done before the freeze, or should I just
> > submit our version?
>
> On ppc64 Im currently setting a console up very early in arch init code
> and using the CONFIG_EARLY_PRINTK hook to disable it at console_init
> time. Works OK for me, do you guys need something on top of that?

Ugh!!! The reason I reworked the console system is because over the years
hack after hack has been added. It now has lead to this twisted monster.
Take a look at the fbdev driver codes in 2.4.X. Instead of another hack
the console system should be cleaned up with a well thought out design to
make the code base smaller and more effiencent.

