Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbTAXT4X>; Fri, 24 Jan 2003 14:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTAXT4X>; Fri, 24 Jan 2003 14:56:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14060 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265094AbTAXT4V>;
	Fri, 24 Jan 2003 14:56:21 -0500
Date: Fri, 24 Jan 2003 11:53:55 -0800 (PST)
Message-Id: <20030124.115355.51751971.davem@redhat.com>
To: Jeff.Wiedemeier@hp.com
Cc: jgarzik@pobox.com, ink@jurassic.park.msu.ru, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030124150006.A2882@dsnt25.mro.cpqcorp.net>
References: <20030124212748.C25285@jurassic.park.msu.ru>
	<20030124193135.GA30884@gtf.org>
	<20030124150006.A2882@dsnt25.mro.cpqcorp.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
   Date: Fri, 24 Jan 2003 15:00:06 -0500

   The problem is that if the chip is configured for MSI (through config
   space) and the platform's irq mapping code therefore filled in
   pci_dev->irq with an appropriate vector for the MSI interrupt the chip
   is assigned instead of the LSI interrupt it may also be assigned, then
   unless MSGINT_MODE matches PCI_MSI_FLAGS_ENABLE, the driver will grab
   wrong interrupt.
   
Why isn't it enabled at the point where we save the extended state?
