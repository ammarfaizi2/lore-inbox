Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130671AbQLEXXN>; Tue, 5 Dec 2000 18:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129738AbQLEXXD>; Tue, 5 Dec 2000 18:23:03 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:27405 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S130649AbQLEXWs>; Tue, 5 Dec 2000 18:22:48 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 5 Dec 2000 15:47:15 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E143QAI-0000GI-00@the-village.bc.nu>
In-Reply-To: <E143QAI-0000GI-00@the-village.bc.nu>
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00120515471500.00866@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 December 2000 15:02, Alan Cox wrote:
>
> > cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
> > cs461x: Unknown card (FFFFFFFF:FFFFFFFF) at 0xf8ffe000/0xf8e00000, IRQ 18
>
> This gets garbage back when it reads the vendor subids. I dont at this
> point see it being a sound bug but a pci layer bug

I just repeated some of my earlier tests, and I was _wrong_ about 
2.4.0-test11-ac1 working with KDE on my machine.  I probably didn't
do the make modules, make modules_install properly, and as a result,
did not have sound and KDE came up properly.  For test11-ac1, the
relevant section of messages is the same as above, and ac1 freezes
on the KDE 2.0 startup.

I did confirm that 2.4.0-test11(final) works properly with sound and KDE 2.0.

I do think its rather odd that these test12-pre3,4,5 kernels all work with
GNOME and the CD player works then.  KDE 2.0 is doing something different
at the "Loading the panel" stage that causes this bug to surface.

If there any config options or tests I can do, please let me know.  I'm 
looking into the serial console thing.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
