Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271922AbRHVSQ1>; Wed, 22 Aug 2001 14:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272074AbRHVSQS>; Wed, 22 Aug 2001 14:16:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40207 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272072AbRHVSQE>; Wed, 22 Aug 2001 14:16:04 -0400
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6-> PNPBIOS life saver
To: Gunther.Mayer@t-online.de (Gunther Mayer)
Date: Wed, 22 Aug 2001 19:18:20 +0100 (BST)
Cc: kraxel@bytesex.org (Gerd Knorr), kuznet@ms2.inr.ac.ru (Alexey Kuznetsov),
        alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Gunther Mayer" at Aug 22, 2001 07:35:23 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Zca4-0001z2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Try -ac Kernels with integrated PNPBIOS and "lspnp -v",
> then you will see your "motherboard resources". No magic.

Except on the intel boards where your machine crashes, the vaio's where
some queries corrupt memory, the boxes where an interrupt during a pnpbios
call crashes the box, the machines where pnpbios called from both cpus at
the same time is a crash case, the wonderful weird tiny races on some boxes
that use smm traps and fail if random undefined things occur between the
two out instructions...

> Alan, 2.4 would largely benefit from PNPBIOS, do you plan
> to submit this to LT (probably with the proposed life saver fix) ?

Experience is that PnpBIOS services are so astoundingly buggy in many
bioses that they are probably not worth the risk. Ie more boxes break by
calling pnpbios than by assuming the vendor used a sane resource layout.

Before PnPBIOS can go mainstream we'd have to generate a detailed list
of buggy bios signatures

Alan
