Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269752AbRHTWs4>; Mon, 20 Aug 2001 18:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269777AbRHTWsq>; Mon, 20 Aug 2001 18:48:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36365 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269752AbRHTWsh>; Mon, 20 Aug 2001 18:48:37 -0400
Subject: Re: BUG: pc_keyb.c
To: Andries.Brouwer@cwi.nl
Date: Mon, 20 Aug 2001 23:51:25 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, lars.segerlund@comsys.se,
        linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Andries.Brouwer@cwi.nl" at Aug 20, 2001 07:46:06 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YxtF-0006vG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the present code does not guarantee such a delay at all.
> For example, kbd_write_cmd() does
> 	kb_wait();
> 	outb(...);
> 	kb_wait();
> where the second kb_wait reads the status very quickly after the first.

Thats wrong by the spec. I dug out my docs - there is a required 1mS (not
2 tho) delay for keyboard port accesses.

