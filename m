Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbUAOQ3j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 11:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbUAOQ3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 11:29:39 -0500
Received: from relaycz.systinet.com ([62.168.12.68]:27019 "HELO
	relaycz.systinet.com") by vger.kernel.org with SMTP id S264974AbUAOQ3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 11:29:38 -0500
Subject: Re: [2.6,2.4] HPT366 (on Abit BP6) + Seagate 7000.7 + DMA = kernel
	halted
From: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1074178780.1400.34.camel@hostmaster.org>
References: <1074103900.22670.27.camel@narsil>
	 <1074178780.1400.34.camel@hostmaster.org>
Content-Type: text/plain
Message-Id: <1074184167.27869.19.camel@narsil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 17:29:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-15 at 15:59, Thomas Zehetbauer wrote:
> Must be a problem with the harddisk; I do also have a Abit BP6 board
> with two WD800JB which work fine on the HPT366 controller. Maybe you
> should try to connect them to one of the PIIX4 IDE channels. Btw: I do
> have CONFIG_IDEDMA_PCI_AUTO enabled so I do not even need to use hdparm
> to enable DMA.
> 

It supports my idea that linux kernel driver miss some 'special'
initialization for Seagate disk. But I need to try HighPoint's own
driver first, hopefully during weekend.

I also know that's not problem of AUTO DMA, I tried it and it didn't
change anything. During boot driver reports that my disk can do only
PIO.

However I am myself not so sure if I should use the HPT366 or the PIIX4
> controller as I got better cache read throughput (hdparm -T) with the
> PIIX4 controller and could avoid sharing an interrupt. Maybe someone
> here is willing to share some piece of advice?
> 

The problem with faster controller is a bit funny. I suppose that the
HPT366 controller is there because of its ability to run UDMA66, so that
it should be faster.

Anyway, thanks for your comments.

Pogo

-- 
Jan Mynarik <mynarikj@phoenix.inf.upol.cz>

