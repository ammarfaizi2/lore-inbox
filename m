Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267364AbTBPUYn>; Sun, 16 Feb 2003 15:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbTBPUYn>; Sun, 16 Feb 2003 15:24:43 -0500
Received: from mail47-s.fg.online.no ([148.122.161.47]:3541 "EHLO
	mail47.fg.online.no") by vger.kernel.org with ESMTP
	id <S267364AbTBPUYm>; Sun, 16 Feb 2003 15:24:42 -0500
Date: Sun, 16 Feb 2003 21:34:33 +0100
From: cheapisp@sensewave.com
To: linux-kernel@vger.kernel.org
Subject: Cardbus slots disappear when booting from pcmcia.
Message-ID: <20030216203433.GA2107@dagb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a problem which best is summed up like this:
- booting from pcmcia works, 
- root on pcmcia works (with initrd), 
- I can't do both at the same time.

This is on a Toshiba Satellite Pro 6000. It has the option of booting from 
pcmcia. This is great when you develop for en embedded x86 target with an 
integrated CF interface. I can just write the diskimage to the CF in the 
pcmcia slot and reboot my laptop from pcmcia, which is nice when you don't 
have the actual hardware you develop for.

In any case, when I boot from pcmcia, the Cardbus slots are no longer detected
by the kernel. And subsequently, there is no root to be found on the CF, as no
pcmcia hardware is found. cardmgr bombs out, telling me that no pcmcia drivers
are loaded.

Booting from pcmcia, but using root on proper disks, lspci shows no trace of
cardbus. Thus, this is not a matter of a misconfigured initrd or 
misconfiguration of pcmcia-cs.
Booting from pcmcia makes my two Cardbus slots disappear.
Booting the identical kernel from disk makes them appear.

And so I wonder: 
why?
is it a bug, or does it have to be this way?
will I have to bug Toshiba about this?

With some tweaking of bios options and cardbus/pcmcia as modules, I can get the 
i82365 module to recognize the *second* pcmcia slot when I boot from the first, 
which is of no use to me.

I have tried 2.4.20 and 2.4.21-pre4-ac4, and a whole load of kernel parameters.
pci=noacpi is required to get an irq for the CF card.

The CardBus controllers are of the ToPIC95 type.


Anyone?

Dag B
