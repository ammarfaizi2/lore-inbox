Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRBSQ2y>; Mon, 19 Feb 2001 11:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRBSQ2f>; Mon, 19 Feb 2001 11:28:35 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37649 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129393AbRBSQ2E>; Mon, 19 Feb 2001 11:28:04 -0500
Subject: Re: Linux 2.4.1-ac15
To: prumpf@mandrakesoft.com (Philipp Rumpf)
Date: Mon, 19 Feb 2001 16:27:58 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        prumpf@parcelfarce.linux.theplanet.co.uk, rusty@linuxcare.com
In-Reply-To: <Pine.LNX.3.96.1010219101008.32729A-100000@mandrakesoft.mandrakesoft.com> from "Philipp Rumpf" at Feb 19, 2001 10:21:04 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UtAP-0003po-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so you hold a spinlock during copy_from_user ?  Or did you change
> sys_init_module/sys_create_modules semantics ?

The only points I need to hold a spinlock are editing the chain and
walking it in a case where I dont hold the kernel lock.

So I spin_lock_irqsave the two ops updating the list links in each case and
the exception lookup walk

