Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129901AbQKWXFy>; Thu, 23 Nov 2000 18:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130455AbQKWXFo>; Thu, 23 Nov 2000 18:05:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11296 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129901AbQKWXF1>; Thu, 23 Nov 2000 18:05:27 -0500
Subject: Re: [PATCH] net drivers cleanup
To: dake@staszic.waw.pl (Bartlomiej Zolnierkiewicz)
Date: Thu, 23 Nov 2000 22:34:53 +0000 (GMT)
Cc: pazke@orbita.don.sitek.net (Andrey Panin),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011232122280.594-100000@tricky> from "Bartlomiej Zolnierkiewicz" at Nov 23, 2000 11:19:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13z4xD-0007qj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -	static unsigned char init_ID_done = 0, version_printed = 0;
> -	int i, irq, irqval, retval;
> +	static unsigned char init_ID_done, version_printed;
> +	int i, irq, retval;
> 
> This is wrong because later we depend on assumption that
> these values are equal to 0 (they aren't autoinitialized to 0).

static starts at zero - its defined


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
