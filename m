Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbSKCVwE>; Sun, 3 Nov 2002 16:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSKCVwD>; Sun, 3 Nov 2002 16:52:03 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:34346 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S264617AbSKCVwB>;
	Sun, 3 Nov 2002 16:52:01 -0500
Date: Sun, 3 Nov 2002 22:58:33 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jos Hulzink <josh@stack.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Petition against kernel configuration options madness...
Message-ID: <20021103215833.GA946@win.tue.nl>
References: <200211031809.45079.josh@stack.nl> <3DC56270.8040305@pobox.com> <20021103200704.A8377@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103200704.A8377@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 08:07:05PM +0100, Vojtech Pavlik wrote:

> > Unfortunately I don't have any concrete suggestions for Vojtech (input 
> > subsystem maintainer), just a request that it becomes easier and more 
> > obvious how to configure the keyboard and mouse that is found on > 90% 
> > of all Linux users computers [IMO]...
> 
> Too bad you don't have any suggestions. I completely agree this should
> be simplified, while I wouldn't be happy to lose the possibility of not
> compiling AT keyboard support in.

Last month or so I suggested adding a hint for Appletalk, and I see
that it is there now:

config LLC
        tristate "ANSI/IEEE 802.2 Data link layer protocol (IPX, Appletalk)"

Such parenthetical remarks will no doubt help a little.
You might try

--- Kconfig~    Thu Oct 31 14:15:06 2002
+++ Kconfig     Sun Nov  3 22:51:45 2002
@@ -5,7 +5,7 @@
 menu "Input device support"
 
 config INPUT
-       tristate
+       tristate "Input devices (needed for mouse, keyboard, ...)"
        default y
        ---help---
          Say Y here if you have any input device (mouse, keyboard, tablet,

and

--- Kconfig~    Thu Oct 31 14:15:06 2002
+++ Kconfig     Sun Nov  3 22:54:28 2002
@@ -2,7 +2,7 @@
 # Input core configuration
 #
 config SERIO
-       tristate "Serial i/o support"
+       tristate "Serial i/o support (needed for keyboard and mouse)"
        ---help---
          Say Yes here if you have any input device that uses serial I/O to
          communicate with the system. This includes the 

(and maybe also sth under keyboard, to tell people that what they have
is called an AT keyboard).

Andries
