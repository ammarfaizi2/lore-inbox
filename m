Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291263AbSBMJIm>; Wed, 13 Feb 2002 04:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291247AbSBMJId>; Wed, 13 Feb 2002 04:08:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36358 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287045AbSBMJIQ>; Wed, 13 Feb 2002 04:08:16 -0500
Subject: Re: 2.5.4 sound module problem
To: alan@clueserver.org
Date: Wed, 13 Feb 2002 09:21:49 +0000 (GMT)
Cc: john.weber@linuxhq.com (John Weber), linux-kernel@vger.kernel.org
In-Reply-To: <200202130752.g1D7qDL22868@clueserver.org> from "Alan" at Feb 12, 2002 09:18:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16avbp-0004ib-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is correct.  It has been a policy to use pci_alloc_consistent
> > instead of kmalloc/getfreepages and virt_to_bus, 2.5 is enforcing it now.
> 
> By breaking sound (in dmabuf and sound modules), cardbus (lots of places), 
> and who knows what else.

It needed breaking. In order to get the drivers portable they need to be
using the DMA API. It shouldn't take too long for the common drivers to
get converted. For much of the sound layer it doesnt matter since the
ALSA code will replace a lot of the older sound stuff.

Alan
