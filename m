Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbULBPRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbULBPRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 10:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbULBPRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 10:17:23 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:64681 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261642AbULBPRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 10:17:20 -0500
Subject: Re: keyboard timeout
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-os@analogic.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412020748070.11261@chaos.analogic.com>
References: <Pine.LNX.4.61.0412011721090.8835@chaos.analogic.com>
	 <1101944709.30770.78.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0412020748070.11261@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101996830.5624.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Dec 2004 14:13:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-02 at 13:11, linux-os wrote:
> >From original IBM specification...
> "...8284A Clock generator clock generator supplies the multiphase
> clock signals that are needed to drive the microprocessor and
> the peripherals. Its base frequency is 14.31818 MHz....."

And the ISA bus side is 8.33Mhz (4.77Mhz on original PC, 6Mhz on
original
XT, originally 10MHz put rapidly fixed back to 8 on some others).

The 1Mhz clock to the keyboard controller is where the required delays
for talking to it come from. Similarly for the other low frequency parts
hacked into the PC (DMA etc).

Our keyboard code appears correct in all respects so you probably want
to adjust the various pc_kbd delays or look to see if you can find one
missing that matters to your PC as I doubt anyone using a post 1990
computer can actually help debug it because their hardware simply won't
care.

Alan

