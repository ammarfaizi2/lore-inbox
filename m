Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbTDWLBB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 07:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbTDWLBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 07:01:01 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:34196 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263998AbTDWLA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 07:00:59 -0400
Subject: Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket initialisation
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: DevilKin <devilkin-lkml@blindguardian.org>
Cc: LKML <linux-kernel@vger.kernel.org>, devilkin-ml@blindguardian.org
In-Reply-To: <200304230747.27579.devilkin-lkml@blindguardian.org>
References: <200304230747.27579.devilkin-lkml@blindguardian.org>
Content-Type: text/plain
Organization: 
Message-Id: <1051096374.653.9.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 23 Apr 2003 13:12:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 07:47, DevilKin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> Kernels 2.5.6[78] hang when the pcmcia yenta_socket is initialised.
> 
> The last message I get is this:
> 
> Apr 23 06:54:22 laptop kernel: Linux Kernel Card Services 3.1.22
> Apr 23 06:54:22 laptop kernel:   options:  [pci] [cardbus] [pm]
> Apr 23 06:54:22 laptop kernel: Intel PCIC probe: not found.
> Apr 23 06:54:22 laptop kernel: PCI: Found IRQ 11 for device 00:03.0
> Apr 23 06:54:22 laptop kernel: PCI: Sharing IRQ 11 with 00:03.1
> Apr 23 06:54:22 laptop kernel: PCI: Sharing IRQ 11 with 00:07.2
> Apr 23 06:54:22 laptop kernel: Yenta IRQ list 0698, PCI irq11
> Apr 23 06:54:22 laptop kernel: Socket status: 30000020
> Apr 23 06:54:22 laptop kernel: PCI: Found IRQ 11 for device 00:03.1
> Apr 23 06:54:22 laptop kernel: PCI: Sharing IRQ 11 with 00:03.0
> Apr 23 06:54:22 laptop kernel: PCI: Sharing IRQ 11 with 00:07.2
> Apr 23 06:54:22 laptop kernel: Yenta IRQ list 0698, PCI irq11
> Apr 23 06:54:23 laptop kernel: Socket status: 30000010

Download and apply the following:

http://patches.arm.linux.org.uk/pcmcia/pcmcia-1.diff

Also, the -mm kernel series starting with 2.5.67-mm4 do include this
patch. You can download -mm patches from
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

