Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264980AbRFUOGa>; Thu, 21 Jun 2001 10:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264981AbRFUOGK>; Thu, 21 Jun 2001 10:06:10 -0400
Received: from mail3.noris.net ([62.128.1.28]:29867 "EHLO mail3.noris.net")
	by vger.kernel.org with ESMTP id <S264980AbRFUOGG>;
	Thu, 21 Jun 2001 10:06:06 -0400
Mime-Version: 1.0
Message-Id: <p05100305b757ae11c10d@[10.2.6.42]>
In-Reply-To: <E15D4VG-0001Lw-00@the-village.bc.nu>
In-Reply-To: <E15D4VG-0001Lw-00@the-village.bc.nu>
Date: Thu, 21 Jun 2001 16:03:49 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, D.A.Fedorov@inp.nsk.su
From: Matthias Urlichs <smurf@noris.de>
Subject: Re: Is it useful to support user level drivers
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), balbir_soni@yahoo.com (Balbir Singh),
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:28 +0100 2001-06-21, Alan Cox wrote:
>No. The IRQ might be shared, and you get a slight problem if you just disabled
>an IRQ needed to make progress for user space to handle the IRQ

Two choices:

- Disallow shared interrupts for usermode drivers.

- Make the 'generic interrupt handler device driver' configurable 
and/or module-extensible. You only need three entry points 
("Interrupt set?"/"Enable interrupts"/"Disable interrupts"), which is 
reasonably simple to get right.
-- 
Matthias Urlichs
