Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279556AbRKRNyP>; Sun, 18 Nov 2001 08:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279570AbRKRNyF>; Sun, 18 Nov 2001 08:54:05 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:27112 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S279556AbRKRNyD>;
	Sun, 18 Nov 2001 08:54:03 -0500
Date: Sun, 18 Nov 2001 14:54:00 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: VM tuning for Linux routers
Message-ID: <20011118145400.A23181@se1.cogenit.fr>
In-Reply-To: <20011117134127.A8041@se1.cogenit.fr> <E1658YH-0008Jp-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1658YH-0008Jp-00@calista.inka.de>; from ecki@lina.inka.de on Sat, Nov 17, 2001 at 05:42:45PM +0100
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels <ecki@lina.inka.de> :
[...]
> You can increase the reserved free memory (not sure where to do this in
> 2.4.x). This is important, cause network memory requests are usually within
> interrupt handlers and therefore no paging can occur. You can play a bit

This reserve isn't dedicated to networking alas.

[...]
> > However you can increase the length of the Rx/Tx rings on the 100Mb/s side 
> > and tune the pci latency timers (depends on the hardware fifo size). 
> 
> Increasing rx/rx rings is not a particular good idea cause it slows down
> TCPs adaption to network congestion and router overload.

Think about forwarding between GigaE and FastE. Think about overflow and
bad irq latency. I wouldn't cut buffering at l2 as it averages the peaks. 
Different trade-offs make sense of course.

-- 
Ueimor
