Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315528AbSEVOpD>; Wed, 22 May 2002 10:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSEVOng>; Wed, 22 May 2002 10:43:36 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:58546 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315540AbSEVOn0>;
	Wed, 22 May 2002 10:43:26 -0400
Date: Wed, 22 May 2002 16:43:12 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Padraig Brady <padraig@antefacto.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020522164312.B1309@ucw.cz>
In-Reply-To: <20020522154902.A361@ucw.cz> <E17AXbD-0001wu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 04:00:23PM +0100, Alan Cox wrote:

> > On Wed, May 22, 2002 at 02:52:19PM +0100, Alan Cox wrote:
> > 
> > > > /sbin/kbdrate: util-linux
> > > 
> > > I'd hope kbrate is using the ioctls nowdays, otherwise it will break on USB
> > 
> > Actually, the ioctls won't work on USB, because they try to output data
> > to the traditional i/o ports anyway.
> 
> The ioctl goes to the keyboard driver. They keyboard driver either
> implements it, errors it or is buggy. No other path. I seem to be able to
> portably set my keyboard rate on everything but USB 8)

Agreed, current method of interfacing USB keyboards to keyboard.c (as
implemented by keybdev.c) is a bug in itself.

-- 
Vojtech Pavlik
SuSE Labs
