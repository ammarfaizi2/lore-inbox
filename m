Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281475AbRKTXK3>; Tue, 20 Nov 2001 18:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281478AbRKTXKT>; Tue, 20 Nov 2001 18:10:19 -0500
Received: from colorfullife.com ([216.156.138.34]:1042 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S281475AbRKTXKI>;
	Tue, 20 Nov 2001 18:10:08 -0500
Message-ID: <3BFAE2D0.5AE002BC@colorfullife.com>
Date: Wed, 21 Nov 2001 00:10:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.15-pre6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: aic7xxx: trying to free free irq
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

if the aic driver in 2.4.15-pre7 aborts the initialization, it doesn't
properly clean up:

from dmesg:
> SCSI subsystem driver Revision: 1.00
> ahc_pci:0:10:0: Using left over BIOS settings
> ahc_pci:0:10:0: No SCB space found
> Trying to free free IRQ12

The reason why it aborted it probably a hardware problem - now it
reports "PCI Device 0:10.0 failed memory mapped test".
But it should not free an irq it never allocated.

--
	Manfred
