Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313531AbSC3Sga>; Sat, 30 Mar 2002 13:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313532AbSC3SgU>; Sat, 30 Mar 2002 13:36:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51716 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313531AbSC3SgI>; Sat, 30 Mar 2002 13:36:08 -0500
Subject: Re: [patch] block/IDE/interrupt lockup
To: akpm@zip.com.au (Andrew Morton)
Date: Sat, 30 Mar 2002 18:52:18 +0000 (GMT)
Cc: manfred@colorfullife.com (Manfred Spraul), linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br (Marcelo Tosatti)
In-Reply-To: <3CA603B0.8B73FD4C@zip.com.au> from "Andrew Morton" at Mar 30, 2002 10:28:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16rNxa-0003UM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel calls request_irq() inside cli() in lots of places.
> That's the same bug: "if you called cli(), how come you're
> allowing kmalloc to clear it?".

Those places should if possible be fixed. I take patches. If we can get 2.4
to BUG() on those kmalloc violations and clean them up it sounds like
progress
