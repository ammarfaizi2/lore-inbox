Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263152AbRE1VQV>; Mon, 28 May 2001 17:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263159AbRE1VQL>; Mon, 28 May 2001 17:16:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18949 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263152AbRE1VQB>; Mon, 28 May 2001 17:16:01 -0400
Subject: Re: [patch]: ide dma timeout retry in pio
To: hahn@coffee.psychology.mcmaster.ca (Mark Hahn)
Date: Mon, 28 May 2001 22:12:31 +0100 (BST)
Cc: axboe@suse.de (Jens Axboe), andre@linux-ide.org, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10105281533400.25183-100000@coffee.psychology.mcmaster.ca> from "Mark Hahn" at May 28, 2001 03:39:00 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154UJT-0003XV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> really?  do we know the nature of the DMA engine problem well enough?

I can categorise some of them:

1.	Hardware that just doesnt support it.
2.	Timeouts that are false positives caused by disks having problems
	and being very slow to recover
3.	Bad cabling
4.	Stalls caused by heavy PCI traffic

> is there a reason to believe that it'll work better "later"?

#1 will go fail, fail, fail -> PIO now (or should do Im about to try it)
#2 and #4 will be transient
#3 could go either way
