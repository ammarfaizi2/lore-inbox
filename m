Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311841AbSCNWnQ>; Thu, 14 Mar 2002 17:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311844AbSCNWnI>; Thu, 14 Mar 2002 17:43:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2053 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311841AbSCNWm7>; Thu, 14 Mar 2002 17:42:59 -0500
Subject: Re: IO delay, port 0x80, and BIOS POST codes
To: root@chaos.analogic.com
Date: Thu, 14 Mar 2002 22:58:16 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020314172335.715C-100000@chaos.analogic.com> from "Richard B. Johnson" at Mar 14, 2002 05:25:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16leAq-00029J-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Correct! The PCI is very much different, I'm glad, and hopefully nobody
> will be using that for deliberate waits.

On the x86 platform the PCI bridges make PCI out instructions synchronous.
Lots of driver code relies on this and people handling ports to non x86
where the odd bridge doesn't do this have had some real fun.

PCI mmio writes are however (even on the good old x86 platform) async

Alan
