Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbTBQTfx>; Mon, 17 Feb 2003 14:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbTBQTfx>; Mon, 17 Feb 2003 14:35:53 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:48827 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267384AbTBQTfw>; Mon, 17 Feb 2003 14:35:52 -0500
Date: Mon, 17 Feb 2003 13:45:35 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Shawn Starr <shawn.starr@datawire.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][2.5.60/61] - Making modules problem
In-Reply-To: <200302171433.09953.shawn.starr@datawire.net>
Message-ID: <Pine.LNX.4.44.0302171343370.5217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Shawn Starr wrote:

> Well, if I take a vanilla kernel, extract it, copy my old .config over, make 
> oldconfig, select anything new, make modules, it used to skim though sources 
> and compile the modules selected. Now, it builds bzImage (or whatever 
> vmlinux) and THEN builds the modules last.

It really builds the modules at the same time (as module.o),
then vmlinux, then the final modules (module.ko)

> If I have a built vmlinux, before I do make modules, it will just compile the 
> modules as it would normally do.

Okay, that's expected, with

> CONFIG_MODVERSIONS=y

So not a bug. Thanks for the details.

--Kai



