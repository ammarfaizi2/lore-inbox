Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262527AbTCIP6W>; Sun, 9 Mar 2003 10:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262529AbTCIP6W>; Sun, 9 Mar 2003 10:58:22 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:3713 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262527AbTCIP6V>; Sun, 9 Mar 2003 10:58:21 -0500
Date: Sun, 9 Mar 2003 10:09:01 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Jason Straight <jason@JeetKuneDoMaster.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64bk3 no screen after Ok booting kernel
In-Reply-To: <200303091052.13291.jason@JeetKuneDoMaster.net>
Message-ID: <Pine.LNX.4.44.0303091007250.1104-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Mar 2003, Jason Straight wrote:

> On Sunday 09 March 2003 02:39 am, Andrew Morton wrote:
> > "Adam J. Richter" <adam@yggdrasil.com> wrote:
> > > On another desktop computer (a P3), I get no kernel printk's but user
> > > level programs print their output.  For example I see fsck print its
> > > output.  However, that computer system hangs after fsck apparently
> > > finishes.  The computer with the console problems under 2.5.64bk3
> > > boots 2.5.64 and 2.5.64bk1 fine.  I haven't tried 2.5.64bk2 yet.
> >
> > Did you try adding "console=tty0" to the boot command?  That got broken
> > too.
> 
> Yeah, got that. I think it's probably the fact that CONFIG_VT_CONSOLE isn't 
> defined because it's not in the menuconfig anywhere, putting it in .config 
> get's cleaned out by checkconfig.pl. 

CONFIG_VT_CONSOLE doesn't appear if you define CONFIG_INPUT as either m or 
n.  Rerun menuconfig, change the CONFIG_INPUT to y and then you can set 
CONFIG_VT_CONSOLE.

