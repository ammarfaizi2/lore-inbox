Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbRBGUze>; Wed, 7 Feb 2001 15:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129832AbRBGUzY>; Wed, 7 Feb 2001 15:55:24 -0500
Received: from brauhaus.paderlinx.de ([194.122.103.4]:44543 "EHLO
	imail.paderlinx.de") by vger.kernel.org with ESMTP
	id <S129063AbRBGUyx>; Wed, 7 Feb 2001 15:54:53 -0500
Date: Wed, 7 Feb 2001 21:54:23 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac5
Message-ID: <20010207215423.A17404@citd.de>
In-Reply-To: <200102072030.VAA06500@ns.caldera.de> <E14QbMw-0001JD-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <E14QbMw-0001JD-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 07, 2001 at 08:39:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > now that -ac grows that huge, could you put out incremental patches?
> 
> Takes me too much time. But if anyone else wants to, go ahead

This is what i use to diff 2 different kernels

- snip -
        diffkernel)
           mount none /d/kernel -t ramfs
           cd /d/kernel
           tar -zxf $1
           cp -a linux linuxa
           cd /d/kernel/linuxa
           zcat $2 | patch -p1 -E -s
           cd /d/kernel/linux
           zcat $3 | patch -p1 -E -s
           cd /d/kernel
           diff -Nur linuxa linux
           cd
           umount /d/kernel
- snip -

This takes about 8 seconds (for 2.4 kernels) on my Dual PIII-933, 1Gig-RAM




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
