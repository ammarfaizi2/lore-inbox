Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261804AbTCaTkY>; Mon, 31 Mar 2003 14:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbTCaTkY>; Mon, 31 Mar 2003 14:40:24 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:6571 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261804AbTCaTkX>; Mon, 31 Mar 2003 14:40:23 -0500
Date: Mon, 31 Mar 2003 14:47:08 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Michael Buesch <freesoftwaredeveloper@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: make menuconfig error
In-Reply-To: <200303312134.38818.freesoftwaredeveloper@web.de>
Message-ID: <Pine.LNX.4.44.0303311445140.11669-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003, Michael Buesch wrote:

> Hi.
> 
> I don't know, if this was posted some time ago, because I was unsubscribed
> for a time.
> I unpacked a vanilla 2.5.66, copied the .config of my already configured
> 2.5.64 to the new kernel, made a make menuconfig and immediately canceled
> it, without saving.
> I got this error-message:
> 
> # bla ...
>   gcc  -o scripts/lxdialog/lxdialog scripts/lxdialog/checklist.o scripts/lxdialog/menubox.o scripts/lxdialog/textbox.o scripts/lxdialog/yesno.o scripts/lxdialog/inputbox.o scripts/lxdialog/util.o scripts/lxdialog/lxdialog.o scripts/lxdialog/msgbox.o -lncurses 
> ./scripts/kconfig/mconf arch/i386/Kconfig
> #
> # using defaults found in .config
> #
> .config:763: trying to assign nonexistent symbol INTEL_RNG

i'm pretty sure that, if you just unpacked the source for the
first time, you should first "make mrproper" just to play it
safe, and after that, you *must* do at least one full config
of some kind, to create a number of header files that are
necessary.  the fact that you said you did a "make menuconfig",
but bailed before you actually saved anything makes me uneasy.

and the INTEL_RNG has something to do with random number
generation.  but can you do a "make oldconfig" and see if
you get the same error?

rday

