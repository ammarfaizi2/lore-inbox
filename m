Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbTAOPRz>; Wed, 15 Jan 2003 10:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbTAOPRz>; Wed, 15 Jan 2003 10:17:55 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:58265 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266535AbTAOPRy>; Wed, 15 Jan 2003 10:17:54 -0500
Date: Wed, 15 Jan 2003 09:26:23 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Russell King <rmk@arm.linux.org.uk>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] add module reference to struct tty_driver
In-Reply-To: <20030115100001.D31372@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0301150925400.24883-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2003, Russell King wrote:

> On Tue, Jan 14, 2003 at 02:08:59PM -0800, Greg KH wrote:
> > Woah!  Hm, this is going to cause lots of problems in drivers that have
> > been assuming that the BKL is grabbed during module unload, and during
> > open().  Hm, time to just fallback on the argument, "module unloading is
> > unsafe" :(
> 
> Note that its the same in 2.4 as well.  iirc, the BKL was removed from
> module loading/unloading sometime in the 2.3 timeline.

You didn't look at linux-2.4/kernel/module.c lately, did you? ;)

--Kai


