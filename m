Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSEPN14>; Thu, 16 May 2002 09:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312634AbSEPN1z>; Thu, 16 May 2002 09:27:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36878 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312619AbSEPN1z>; Thu, 16 May 2002 09:27:55 -0400
Subject: Re: Q: x86 interrupt arrival after cli
To: bart@jukie.net (Bart Trojanowski)
Date: Thu, 16 May 2002 14:32:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020515202720.D15996@jukie.net> from "Bart Trojanowski" at May 15, 2002 08:27:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178LMh-0004FK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Quick question for the x86 gurus:
> 
> If a hardware interrupt arrives within a spin_lock_irqsave &
> spin_unlock_irqrestore will the interrupt handler associated with said
> interrupt be called immediately after the spinlock is released? =20

It will be called as soon as the cpu hardware gets around to it - which 
should be just after the irq mask flag is cleared. 
