Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318418AbSGYL0P>; Thu, 25 Jul 2002 07:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318419AbSGYL0P>; Thu, 25 Jul 2002 07:26:15 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29195 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318418AbSGYL0O>; Thu, 25 Jul 2002 07:26:14 -0400
Date: Thu, 25 Jul 2002 07:17:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: martin@dalecki.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Safety of IRQ during i/o
In-Reply-To: <1027592784.9489.11.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1020725071201.10698A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jul 2002, Alan Cox wrote:

> There are also some older systems where if the block transfer of the IDE
> data didn't keep up with the controller instead of handshaking properly
> it kind of dribbled random numbers onto the disk.
> 
> Unless anyone knows of PCI era devices with this problem I would be
> inclined to agree that we should default to IRQ unmasking in the 2.5 IDE
> code if the IDE controller is PCI.

Certainly if the controller is running in DMA mode. If running in PIO mode
I would think you could still have a problem if the transfer was stopped
mid-block. Perhaps I'm paranoid, is that a "can't happen" now?
 
> For old ISA/VLB controllers its safer left as is, and nobody running a
> machine like that can realistically expect good performance without hand
> tuning stuff anyway

I would think the guts of PIO block transfer would have to be protected
anyway, but that's a very small part of the code. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

