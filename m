Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbRFPS0q>; Sat, 16 Jun 2001 14:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264643AbRFPS0i>; Sat, 16 Jun 2001 14:26:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45324 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264638AbRFPS0f>; Sat, 16 Jun 2001 14:26:35 -0400
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 16 Jun 2001 19:23:56 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), eric@brouhaha.com (Eric Smith),
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox),
        arjanv@redhat.com, mj@ucw.cz
In-Reply-To: <Pine.LNX.4.21.0106161055040.9713-100000@penguin.transmeta.com> from "Linus Torvalds" at Jun 16, 2001 11:10:16 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15BKjk-0008Pu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cardbus shouldn't be touching the bus stuff at all, BUT there may be
> strange hardware that doesn't like the following:
> 
>         config_writeb(socket, PCI_SEC_LATENCY_TIMER, 176); 
> 	config_writeb(socket, PCI_PRIMARY_BUS, dev->bus->number);
>         config_writeb(socket, PCI_SECONDARY_BUS, dev->subordinate->number);
>         config_writeb(socket, PCI_SUBORDINATE_BUS, dev->subordinate->number);
> 
> I have heard rumors of PCI devices that want all these set with a single
> double-word write.

That would be consistent with the behaviour in the bugzilla report - it went
from 0,0,0,1 to  176,0,0,0...

Alan

