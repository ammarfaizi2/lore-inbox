Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130989AbQJ2LgK>; Sun, 29 Oct 2000 06:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131632AbQJ2Lfv>; Sun, 29 Oct 2000 06:35:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25634 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130989AbQJ2Lfm>; Sun, 29 Oct 2000 06:35:42 -0500
Subject: Re: tcp_do_sendmsg() allocation still broken ?
To: ak@suse.de (Andi Kleen)
Date: Sun, 29 Oct 2000 11:36:57 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti), ak@suse.de (Andi Kleen),
        davem@redhat.com (Dave S. Miller), linux-kernel@vger.kernel.org
In-Reply-To: <20001029021642.A16126@gruyere.muc.suse.de> from "Andi Kleen" at Oct 29, 2000 02:16:42 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pqlm-00061I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Think about nbd. 
> 
> Making tcp_do_sendmsg use GFP_ATOMIC would make it too unreliable for other
> situations. Penalizing the whole system just for nbd is not a good idea.

Nobody is saying that. tcp_do_sendmsg should honour the existing 
sk->allocation flag


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
