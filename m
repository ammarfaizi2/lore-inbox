Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272247AbRHWMrs>; Thu, 23 Aug 2001 08:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272250AbRHWMri>; Thu, 23 Aug 2001 08:47:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35078 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272247AbRHWMr1>; Thu, 23 Aug 2001 08:47:27 -0400
Subject: Re: [PATCH] this patch add a possibility to add a random offset to the stack on exec.
To: johnpol@2ka.mipt.ru
Date: Thu, 23 Aug 2001 13:47:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <200108230130.f7N1Uol14698@www.2ka.mipt.ru> from "Evgeny Polyakov" at Aug 23, 2001 05:32:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZttT-0003kI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Add a possibility to add a random offset to the stack on exec. This makes
> it slightly harder to write generic buffer overflows. This doesn't really
> give any real security, but it raises the bar for script-kiddies and it's
> really cheap."

Its so slight its useless, and the randomness makes it hard to verify you
fixed a problem. Remember once an exploit appears a box will get scanned
hundreds of times - someone will get the right offset 8)

There is another good reason for offseting stacks within the page -
especially the kernel stacks which is to avoid things like each apache
task sleeping with wait queues on the same cache colour
