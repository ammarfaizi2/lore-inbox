Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132281AbRDUASU>; Fri, 20 Apr 2001 20:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbRDUASL>; Fri, 20 Apr 2001 20:18:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40201 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132281AbRDUASF>; Fri, 20 Apr 2001 20:18:05 -0400
Subject: Re: SMP in 2.4
To: mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka)
Date: Sat, 21 Apr 2001 01:16:04 +0100 (BST)
Cc: dennis@etinc.com (Dennis), matti.aarnio@zmailer.org (Matti Aarnio),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1010421013436.8002A-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Apr 21, 2001 01:53:42 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ql4I-0002Yh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	testb %al, intr_pending
> 	jnz somewhere_away_to_handle_defered_interrupt
> 
> And - of course - interrupt checks intr_lock in its entry and if it is
> zero, sets intr_pending and exits immediatelly.

And immediately gets called again. You have to mask the irq which is non trivial
especially if you want to do it right on the BX. But you can do this and rtlinux
does

