Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbSJMTRx>; Sun, 13 Oct 2002 15:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSJMTRx>; Sun, 13 Oct 2002 15:17:53 -0400
Received: from zork.zork.net ([66.92.188.166]:64727 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S261404AbSJMTRw>;
	Sun, 13 Oct 2002 15:17:52 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with ide-scsi kernel module
References: <Pine.LNX.4.44.0210131410120.2020-100000@theretriever.org>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: DRUGS/ALCOHOL, DISHONOURABLE
 INTENTIONS
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 13 Oct 2002 20:23:43 +0100
In-Reply-To: <Pine.LNX.4.44.0210131410120.2020-100000@theretriever.org> (solrosin@mail.theretriever.org's
 message of "Sun, 13 Oct 2002 14:11:58 -0500 (CDT)")
Message-ID: <6un0piywg0.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  solrosin@mail.theretriever.org quotation:

> It would appear that there is a problem in the ide-scsi kernel module.  I 
> HAVE properly built the kernel beforehand, so I know it's not a matter of 
> the kernel being improperly built.  Here's the error message I'm getting 
> when I try to insmod ide-scsi:
>  
> Using /lib/modules/2.4.19/kernel/drivers/scsi/ide-scsi.o
> /lib/modules/2.4.19/kernel/drivers/scsi/ide-scsi.o: unresolved symbol 
> scsi_unregister_module_R81d85a75
> /lib/modules/2.4.19/kernel/drivers/scsi/ide-scsi.o: unresolved symbol 
> scsi_register_Rfb1392b2
> /lib/modules/2.4.19/kernel/drivers/scsi/ide-scsi.o: unresolved symbol 
> scsi_register_module_Rfa20b7b0

Try using modprobe instead of insmod.  ide-scsi depends on scsi_mod,
which appears to contain those symbols.  modprobe will load all
dependent modules automatically.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
