Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267413AbTBQTwB>; Mon, 17 Feb 2003 14:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267414AbTBQTwB>; Mon, 17 Feb 2003 14:52:01 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:51387 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267413AbTBQTwA>; Mon, 17 Feb 2003 14:52:00 -0500
Date: Mon, 17 Feb 2003 14:01:53 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Shawn Starr <shawn.starr@datawire.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][2.5.60/61] - Making modules problem
In-Reply-To: <200302171456.51497.shawn.starr@datawire.net>
Message-ID: <Pine.LNX.4.44.0302171357270.5217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Shawn Starr wrote:

> Not a bug but I think an annoyance because sometimes I just want to recompile 
> just the modules using the same kernel version and not have to build the 
> whole thing just to get modules.

You have CONFIG_MODVERSIONS=y. Say your module is using printk(). So your 
module needs to know the checksum for printk(). This checksum is generated 
during the build of kernel/printk.c and then propagated into vmlinux, 
which is where the module build gets it from.

That's why you need printk.o / vmlinux to build the module. If you 
don't want these checks, turn of CONFIG_MODVERSIONS and it's back to what 
it used to be.

--Kai
 

