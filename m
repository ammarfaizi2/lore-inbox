Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129105AbQKLPJd>; Sun, 12 Nov 2000 10:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129237AbQKLPJO>; Sun, 12 Nov 2000 10:09:14 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:24368 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129105AbQKLPJE>; Sun, 12 Nov 2000 10:09:04 -0500
Date: Sun, 12 Nov 2000 17:16:49 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: lav@yars.free.net
cc: linux-kernel@vger.kernel.org
Subject: Re: sound problems caused by masking irq for too long
In-Reply-To: <20001112165609.A1006@long.yar.ru>
Message-ID: <Pine.LNX.4.21.0011121715140.9477-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2000, Alexander V. Lukyanov wrote:

> Hi!
> 
> In some cases sound gets interrupted for a moment, this happens in two
> occasions. When unmaskirq flag is off on ide cdrom and it is accessed,
> and when tdfxfb console (800x600) flashes (tput flash, or `set bell-style
> visible' in .inputrc).
> 
> It seems the problem is caused by masking irq for too long, and then
> the sound dma buffer underruns. This is fixed by unmasking irq for ide
> cdrom by `hdparm -u1 /dev/cdrom', and by changing spin_(un)lock_irq
> in console.c to spin_(un)lock_bh.
> 
> This was observed on 2.4.0-pre10, the problem with ide also exists on
> 2.2.17, the console.c in 2.2.17 only disables CONSOLE_BH.

The above story also explains why my sound 'hickups' when I switch from
console to X (yes, and I do that a lot).

Is this a recent change from 2.2.15 -> >= 2.2.16 or so ?

> The audio card is old awe32 (isa), sound driver is modular.

This is a SB16 PnP



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
