Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274989AbRJFMzt>; Sat, 6 Oct 2001 08:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274990AbRJFMzj>; Sat, 6 Oct 2001 08:55:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30478 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274989AbRJFMzb>; Sat, 6 Oct 2001 08:55:31 -0400
Subject: Re: Question about rtc_lock
To: jdthood@mail.com (Thomas Hood)
Date: Sat, 6 Oct 2001 14:01:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1002340196.813.64.camel@thanatos> from "Thomas Hood" at Oct 05, 2001 11:49:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pr4y-0001CV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                 spin_lock(&rtc_lock);
>                 CMOS_WRITE(v, sbf_port);
>                 spin_unlock(&rtc_lock);
> 
> Does this code run with irqs disabled, or should these
> spinlocks be _irq ?

The CMOS isnt accessed from IRQ handlers
