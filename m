Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264959AbRFUNaG>; Thu, 21 Jun 2001 09:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264958AbRFUN34>; Thu, 21 Jun 2001 09:29:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10000 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264956AbRFUN3k>; Thu, 21 Jun 2001 09:29:40 -0400
Subject: Re: Is it useful to support user level drivers
To: D.A.Fedorov@inp.nsk.su
Date: Thu, 21 Jun 2001 14:28:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), balbir_soni@yahoo.com (Balbir Singh),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.10.10106211905030.3193032-100000@Sky.inp.nsk.su> from "Dmitry A. Fedorov" at Jun 21, 2001 07:45:51 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15D4VG-0001Lw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lastly an IRQ kernel module can disable_irq() from interrupt handler
> and enable it again only on explicit acknowledge from user.

No. The IRQ might be shared, and you get a slight problem if you just disabled
an IRQ needed to make progress for user space to handle the IRQ

