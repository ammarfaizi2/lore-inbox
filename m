Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSEVOk6>; Wed, 22 May 2002 10:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315528AbSEVOk5>; Wed, 22 May 2002 10:40:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50449 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315440AbSEVOkQ>; Wed, 22 May 2002 10:40:16 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Wed, 22 May 2002 16:00:23 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), padraig@antefacto.com (Padraig Brady),
        dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20020522154902.A361@ucw.cz> from "Vojtech Pavlik" at May 22, 2002 03:49:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AXbD-0001wu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, May 22, 2002 at 02:52:19PM +0100, Alan Cox wrote:
> 
> > > /sbin/kbdrate: util-linux
> > 
> > I'd hope kbrate is using the ioctls nowdays, otherwise it will break on USB
> 
> Actually, the ioctls won't work on USB, because they try to output data
> to the traditional i/o ports anyway.

The ioctl goes to the keyboard driver. They keyboard driver either
implements it, errors it or is buggy. No other path. I seem to be able to
portably set my keyboard rate on everything but USB 8)
