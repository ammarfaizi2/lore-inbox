Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289359AbSAOCAg>; Mon, 14 Jan 2002 21:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289357AbSAOCA0>; Mon, 14 Jan 2002 21:00:26 -0500
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:63482 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S289355AbSAOCAX>;
	Mon, 14 Jan 2002 21:00:23 -0500
Date: Mon, 14 Jan 2002 21:03:00 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Christoph Dworzak <linuxkernel@amazing.ch>
cc: linux-kernel@vger.kernel.org, tulip@scyld.com
Subject: Re: [tulip] 2.4.17 tulip multiport-patch
In-Reply-To: <20020115020413.B11753@amazing.ch>
Message-ID: <Pine.LNX.4.10.10201142101040.892-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Christoph Dworzak wrote:

> After lots of Headscratching, I found this little bug:
> 
> replace line 1642 of tulip_core.c:
> 
> 		    irq = last_irq;
> 
> with
> 
> 		    dev->irq = irq = last_irq;

Hmmm, a little bit of bad conversion here.  The tulip.c code follows
this section by

     dev->irq = irq;

a few lines later.

> While using the de4x5-driver, my system-load climbed steadily
> up. After 3 Days it was at 99.5%.

Check the interrupt count in /dev/interrupts.

> This was repeatable. -> Reboot every other day :(

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

