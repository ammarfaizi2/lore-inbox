Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbTHaNdb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 09:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbTHaNdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 09:33:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64274 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261711AbTHaNd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 09:33:29 -0400
Date: Sun, 31 Aug 2003 14:33:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 experiences
Message-ID: <20030831143327.B9032@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030831131313.GA1049@wiland.intern>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030831131313.GA1049@wiland.intern>; from berberic@fmi.uni-passau.de on Sun, Aug 31, 2003 at 03:13:13PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 03:13:13PM +0200, M G Berberich wrote:
> i tried 2.6.0-test on a laptop (Sony Vaio FX502, AMD Mobile Duron
> 1GHz)
> 
> With a PCMCIA-Modem (ELSA Microlink 56k MC Internet, a V.90 Modem) I
> have only 1/3 throughput with 2.6.0-test4 compared to a 2.4.X kernel
> (which gives the normal throughput for 56k modem).
> 
>      Yenta: CardBus bridge found at 0000:00:0a.0 [104d:80f6]
>      Yenta IRQ list 0008, PCI irq11
>      Socket status: 30000010
>      Yenta: CardBus bridge found at 0000:00:0a.1 [104d:80f6]
>      Yenta IRQ list 0008, PCI irq10
>      Socket status: 30000006
>      cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xdc000-0xdffff 0xe4000-0xfffff
>      serial_cs: RequestIRQ: Unsupported mode

Make sure you have CONFIG_ISA=y in your kernel configuration.
However, I'm thinking that maybe if CONFIG_ISA is not set, we
shouldn't probe ISA IRQs in yenta_socket...

> pulling the card out I get
> 
>      Trying to free nonexistent resource <000002f8-000002ff>

Proper fix for this is behind a large pile of other interdependent patches.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

