Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272773AbRJYMQr>; Thu, 25 Oct 2001 08:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271667AbRJYMQh>; Thu, 25 Oct 2001 08:16:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29455 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272838AbRJYMQZ>; Thu, 25 Oct 2001 08:16:25 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 25 Oct 2001 13:22:32 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20011025075832.27776@smtp.wanadoo.fr> from "Benjamin Herrenschmidt" at Oct 25, 2001 09:58:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wjWq-0004ht-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Sound is more easily handled by not blocking user space but waiting until
> >the final IRQ off moment and grabbing the registers. That avoids a lot
> >of ugly locking gunge. It literally comes down to
> 
> My point about using a semaphore was to avoid getting mixer ioctls
> banging the HW while it is shut down.

Yes I can follow that - you want to avoid the aclink being shut down while
active. That seems to be just part of the ordering. I'd also put the ac97
save/restore in the ac97_codec.c stuff - lets write it once 8)
