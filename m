Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262899AbRE1BuF>; Sun, 27 May 2001 21:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbRE1Btp>; Sun, 27 May 2001 21:49:45 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:37623 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S262899AbRE1Bte>; Sun, 27 May 2001 21:49:34 -0400
Date: Sun, 27 May 2001 18:49:17 -0700 (PDT)
From: Chris Rankin <rankinc@pacbell.net>
Subject: Re: Hard lockup switching to X from vc; Matrox G400 AGP
In-Reply-To: <20010528024250.C1244@ppc.vc.cvut.cz>
To: vandrove@vc.cvut.cz (Petr Vandrovec)
Cc: b.twijnstra@chello.nl (Ben Twijnstra), linux-kernel@vger.kernel.org
Message-id: <200105280149.f4S1nIs10660@wellhouse.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL3]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks for confirming this. But if it's Matrox's code (we are
talking about the mga_hal_drv.o module for X, correct?) then the ball
is in their court. Has anyone reported this to them so that they can
fix it?

Cheers,
Chris
 
> On Mon, May 28, 2001 at 12:24:50AM +0200, Ben Twijnstra wrote:
> > Hi Chris,
> > 
> > Seen the same behaviour; you're not alone. I'm running XF86 4.0.3 with 
> > a G400. My guess is that mga_drv goes into some local loop while trying 
> > to restore the display. mga_drv at that moment has I/O privileges and if 
> > it hangs, Linux hangs too.
> 
> It is problem with their driver. Their are resetting too much of
> hardware state during mode switches and if someone accesses memory
> at that moment, whole thing locks up your PCI bus - if you have ATX
> box, try hitting poweroff button next time it lockups. If poweroff
> does not work you'll have bad time to get it debugged. If poweroff
> button works, you can try kdb...
> 
> On my machine it is 100% reproducible if I run 'fbtv -k' and start X.
> It will die immediately.
