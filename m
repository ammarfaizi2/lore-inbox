Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264279AbRF0LXt>; Wed, 27 Jun 2001 07:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264805AbRF0LXj>; Wed, 27 Jun 2001 07:23:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50960 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264279AbRF0LX1>; Wed, 27 Jun 2001 07:23:27 -0400
Subject: Re: PCI Power Management / Interrupt Context
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Wed, 27 Jun 2001 12:22:39 +0100 (BST)
Cc: eger@cc.gatech.edu (David T Eger), linux-kernel@vger.kernel.org
In-Reply-To: <3B395A7A.848908C@mandrakesoft.com> from "Jeff Garzik" at Jun 27, 2001 12:00:58 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FDP5-000528-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if someone yanks the card, how is it going to deliver an interrupt to
> the CPU?

It can happen actually. There is also a window where you can disable an IRQ
on a card and then take an IRQ. The ne2k driver has to jump through a couple
of hoops because of this
