Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292367AbSBUNSe>; Thu, 21 Feb 2002 08:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292363AbSBUNSP>; Thu, 21 Feb 2002 08:18:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23044 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292292AbSBUNRy>; Thu, 21 Feb 2002 08:17:54 -0500
Subject: Re: SMP problems
To: fernando@quatro.com.br
Date: Thu, 21 Feb 2002 13:32:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <004a01c1bad5$dd4a02a0$c50016ac@spps.com.br> from "Fernando Korndorfer" at Feb 21, 2002 09:47:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dtKd-0006ur-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         I'm having some problems copiling the latest kernel with SMP (and
> w/o too). If I boot a SMP-enabled kernel, the system hangs after detecting
> the second CPU. and I can't compile the kernel w/o SMP support (it causes a
> lot of 'redefinitions'...). Can anyone help me?

make distclean when switching between SMP and non SMP builds. If the box
is hanging on detecting both processors then

-	If its a dual Athlon switch to MP 1.1 tables in the BIOS
-	Otherwise try specifying "noapic"
