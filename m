Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293662AbSCKJ6C>; Mon, 11 Mar 2002 04:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293664AbSCKJ56>; Mon, 11 Mar 2002 04:57:58 -0500
Received: from mail.scram.de ([195.226.127.117]:29165 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S293662AbSCKJ5o>;
	Mon, 11 Mar 2002 04:57:44 -0500
Date: Mon, 11 Mar 2002 10:57:40 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
To: <linux-kernel@vger.kernel.org>
Subject: Busmaster DMA broken in 2.4.18 on Alpha
Message-ID: <Pine.NEB.4.33.0203111049580.1675-100000@www2.scram.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it looks like the change to pci_iommu.c in 2.4.18 breaks busmaster DMA for
alpha. The reason is that ISA_DMA_MASK is now 0xffffffff instead of
0x00ffffff as it was before. So the allocated memory is no longer
reachable from the ISA card.

I had to revert this change to make my ISA token ring card (tms380 based)
work again on alpha.

Cheers,
Jochen

