Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274964AbRJILZF>; Tue, 9 Oct 2001 07:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275120AbRJILYo>; Tue, 9 Oct 2001 07:24:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58631 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274964AbRJILYg>; Tue, 9 Oct 2001 07:24:36 -0400
Subject: Re: [PATCH] change name of rep_nop
To: etienne_lorrain@yahoo.fr (=?iso-8859-1?q?Etienne=20Lorrain?=)
Date: Tue, 9 Oct 2001 12:30:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011009085140.85739.qmail@web11801.mail.yahoo.com> from "=?iso-8859-1?q?Etienne=20Lorrain?=" at Oct 09, 2001 10:51:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qv5s-0003oy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Hello,
> > 	__asm__ __volatile__("rep;nop");
> 
> "The behavior of the REP prefix is undefined when used with non-string
> instructions." page 3-404 of Intel documentation, in "CHAPTER 3,
> INSTRUCTION SET REFERENCE"...
> 
>   How about: __asm__ __volatile__("loop ." : "+c" (nbloop)); ?

rep nop is a magic instruction to powersave momentarily on the Pentium 4.
It happens to be a true nop on the older processors
