Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319539AbSIGXE0>; Sat, 7 Sep 2002 19:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319540AbSIGXE0>; Sat, 7 Sep 2002 19:04:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59889 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S319539AbSIGXEZ>; Sat, 7 Sep 2002 19:04:25 -0400
Date: Sun, 8 Sep 2002 01:08:59 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Sam Ravnborg <sam@ravnborg.org>
cc: Adam Johnson <adamj@valley.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Problem: kernel 2.5.33 won't compile
In-Reply-To: <20020907093956.A1826@mars.ravnborg.org>
Message-ID: <Pine.NEB.4.44.0209080103170.7218-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Sep 2002, Sam Ravnborg wrote:

> On Fri, Sep 06, 2002 at 06:05:52PM -0400, Adam Johnson wrote:
> >     I get this error message when I try to compile 2.5.33:
> > drivers/built-in.o(.data+0x2d8d4): undefined reference to `local symbols
> > in discarded section .text.exit'
>
> Try seaching ihttp://marc.theaimsgroup.com
> Hint: binutils compatibility problem, time to upgrade.

Your answer is 100% wrong:

- You see this problem only with recent binutils, so a workaround would be
  to _downgrade_ binutils.
- These .text.exit errors are generally considered bugs in the kernel.
  (Most of them are already fixed in recent kernels.)
- I suspect CONFIG_DE2104X and/or CONFIG_DM9102 is set in the .config, and
  then it's a well-known error.


> 	Sam

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


