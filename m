Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261536AbSJURSP>; Mon, 21 Oct 2002 13:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbSJURSP>; Mon, 21 Oct 2002 13:18:15 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:13764 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261536AbSJURSO>;
	Mon, 21 Oct 2002 13:18:14 -0400
Date: Mon, 21 Oct 2002 10:22:38 -0700
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: 2.5.42: IrDA issues
Message-ID: <20021021172238.GF20404@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <7034136.1034515639605.JavaMail.nobody@web11.us.oracle.com> <20021014173421.GC10672@bougret.hpl.hp.com> <3DB3C6A7.5040007@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB3C6A7.5040007@oracle.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 11:19:35AM +0200, Alessandro Suardi wrote:
> Jean Tourrilhes wrote:
> >On Sun, Oct 13, 2002 at 05:27:19AM -0800, ALESSANDRO.SUARDI wrote:
> >
> >>I have a PPP over IrDA connection to my Nokia phone; under 2.4.20-preX I 
> >>have no
> >>problem keeping the link up, while in 2.5.4x it fails in a very short 
> >>time like this:
> >>
> >>Oct 13 01:13:13 dolphin kernel: IrLAP, no activity on link!
> >>Oct 13 01:13:11 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
> >>Oct 13 01:13:11 dolphin kernel: irda0: transmit timed out
> >>Oct 13 01:13:13 dolphin kernel: IrLAP, no activity on link!
> >>Oct 13 01:13:13 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
> >>Oct 13 01:13:13 dolphin kernel: irda0: transmit timed out
> >>Oct 13 01:13:13 dolphin pppd[5378]: Modem hangup
> >>Oct 13 01:13:13 dolphin pppd[5378]: Connection terminated.
> >>Oct 13 01:13:13 dolphin pppd[5378]: Connect time 1.8 minutes.
> >>Oct 13 01:13:13 dolphin pppd[5378]: Sent 19541 bytes, received 35933 
> >>bytes.
> >>Oct 13 01:13:13 dolphin pppd[5378]: Exit.
> >>
> >>I also get the transmit timed out spam (why one with WATCHDOG and one 
> >>without ?)
> >>in 2.4.20-pre but the IrLAP line isn't there. And the GPRS link stays 
> >>up...
> >>
> >>
> >>Thanks in advance for any insight,
> >>
> >>--alessandro
> >
> >
> >	Please do yourself a favor and give me a proper bug report,
> >including hardware, driver and irdadump.
> >
> 
> Will provide irdadump stuff soon[-ish], I'm wading through a backlog
>  of, uhm, too much email. The short-form report really meant "is this
>  a known issue ?"...

	irtty is busted, that's why I asked for the driver you are
using (its clearly a driver issue). I believe smc-ircc and irport are
sick as well.

> Anyway - the box is a Dell Latitude CPx750J with this:
> 
> [root@dolphin root]# findchip -v
> Found SMC FDC37N958FR Controller at 0x3f0, DevID=0x01, Rev. 1
>     SIR Base 0x3e8, FIR Base 0x290
>     IRQ = 4, DMA = 3
>     Enabled: yes, Suspended: no
>     UART compatible: yes
>     Half duplex delay = 3 us
> 
> So clearly I'm using smc-ircc.o.
> 
> (Of course I'll try and reproduce in 2.5.44 tonight or tomorrow).

	Stop ! Daniele Peri has just released a new version of the SMC
driver (smc-ircc2, link on my web page). I would like you to try this
new driver and report to me. I plan to push this new driver in the
kernel soon. So, don't waste too much time on the old driver.

> Thanks,
> 
> --alessandro

	Have fun...

	Jean
