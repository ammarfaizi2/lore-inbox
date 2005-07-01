Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVGAWVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVGAWVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 18:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVGAWVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 18:21:00 -0400
Received: from khc.piap.pl ([195.187.100.11]:260 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S262826AbVGAWUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 18:20:53 -0400
To: linux-os@analogic.com
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       christos gentsis <christos_gentsis@yahoo.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI-X support
References: <42C58203.40606@yahoo.co.uk>
	<Pine.LNX.4.61.0507011357290.5350@chaos.analogic.com>
	<42C585CE.1060509@yahoo.co.uk>
	<Pine.LNX.4.61.0507011453380.4921@chaos.analogic.com>
	<20050701190939.GA2154@ucw.cz>
	<Pine.LNX.4.61.0507011514570.5048@chaos.analogic.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 02 Jul 2005 00:20:47 +0200
In-Reply-To: <Pine.LNX.4.61.0507011514570.5048@chaos.analogic.com> (Richard
 B. Johnson's message of "Fri, 1 Jul 2005 15:25:33 -0400 (EDT)")
Message-ID: <m3oe9mtbgg.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <linux-os@analogic.com> writes:

> Yep. The board uses a PLX PCI 9656BA chip configured for local-bus
> transfers during DMA The local-bus is 32-bits from a FIFO. There
> is no way to collapse these writes from the 32-bit source/dest.
> The transfers are 32 quadwords for a write and 16 quadwords for
> a read, but that represents a burst, not the data-width. Without
> a 64-bit data-path to memory on one side, and a 64-bit data-path
> to the device (a FIFO) on the other side, you will not get 64-bit
> transfers.

I don't know about this particular bridge, but in general you can
have 64-bit transfers over PCI(-X) corresponding to 32-bit transfers
over local bus. The local bus has to be twice as fast as PCI bus or
you won't be able to saturate PCI bus. Especially if it's the bridge
doing PCI BM DMA transfers (and not, say, another processor on the
local bus).
-- 
Krzysztof Halasa
