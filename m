Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTEER1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbTEER1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:27:50 -0400
Received: from mail.ithnet.com ([217.64.64.8]:34312 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261168AbTEER1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 13:27:48 -0400
Date: Mon, 5 May 2003 19:26:52 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Karsten Keil <kkeil@suse.de>
Cc: alan@lxorguk.ukuu.org.uk, kai@tp1.ruhr-uni-bochum.de,
       linux-kernel@vger.kernel.org
Subject: Re: ISDN massive packet drops while DVD burn/verify
Message-Id: <20030505192652.7f17ea9e.skraw@ithnet.com>
In-Reply-To: <20030505164653.GA30015@pingi3.kke.suse.de>
References: <20030416151221.71d099ba.skraw@ithnet.com>
	<Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu>
	<20030419193848.0811bd90.skraw@ithnet.com>
	<1050789691.3955.17.camel@dhcp22.swansea.linux.org.uk>
	<20030505164653.GA30015@pingi3.kke.suse.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003 18:46:53 +0200
Karsten Keil <kkeil@suse.de> wrote:

> > How did we manage to become that bad?
> 
> Its not so bad, the problem is how do you tune the system. If you prefer to
> not interrupt the IDE transfers, which seems to be the default case, you
> loose IRQ latency, which doesn't matter in much cases, but not on
> this. You can tune it (hdparm work also with cdwriters, since
> even if it use ide-scsi, the underlying driver is the ide driver.

You mean UDMA 2 does not make it (which I had in the test case)?

# hdparm -i /dev/hdc

/dev/hdc:

 Model=SONY DVD RW DRU-500A, FwRev=2.0c, SerialNo=DA5B9D3D
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no
 Drive conforms to: device does not report version:  4 5 6

> This all don't say that here maybe also other problems around, but I have no
> better explanation.

Hm, this looks like the unresolved sleeping AVM Fritz2 syndrome to me: no idea
of what's really going on ...

-- 
Regards,
Stephan
