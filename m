Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315547AbSEVOne>; Wed, 22 May 2002 10:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSEVOmf>; Wed, 22 May 2002 10:42:35 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:54706 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315441AbSEVOm3>;
	Wed, 22 May 2002 10:42:29 -0400
Date: Wed, 22 May 2002 16:42:12 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020522164212.A1309@ucw.cz>
In-Reply-To: <20020522155603.B765@ucw.cz> <E17AXZW-0001wM-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 03:58:38PM +0100, Alan Cox wrote:

> > > IOCTL is ineed the way to go to implement such functionality...
> > 
> > Yes, the EVIOCSREP ioctl will be the one soon (works for USB keyboards
> > now).
> 
> The KBDRATE ioctl is already supported by all other keyboard drivers and
> used by XFree86....

Correct. And it'll work on USB as well once the console code is
interfaced to USB better than just by injecting scancodes into
pc_keyb.c.

KBDRATE will work on console, while EVIOCSREP will work if you open the
keyboard as an event device.

-- 
Vojtech Pavlik
SuSE Labs
