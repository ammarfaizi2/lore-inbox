Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQKFRf4>; Mon, 6 Nov 2000 12:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQKFRfq>; Mon, 6 Nov 2000 12:35:46 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:20212 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129213AbQKFRf3>;
	Mon, 6 Nov 2000 12:35:29 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E13spve-0006Pt-00@the-village.bc.nu> 
In-Reply-To: <E13spve-0006Pt-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        jgarzik@mandrakesoft.com (Jeff Garzik), goemon@anime.net (Dan Hollis),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 17:34:33 +0000
Message-ID: <9399.973532073@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
> > No! The best way to do it are just *persistently loaded* modules.
> > It's THAT simple!
>
 So you want to split every sound driver into two or more modules ? 

The point here is that although I've put up with just keeping the sound 
driver loaded for the last few years, permanently taking up a large amount 
of DMA memory, the inter_module_xxx stuff that Keith is proposing would 
give us a simple way of storing the data which we want to store. 

It's even simpler (and cleaner) than having to split all the sound drivers 
up into data and worker modules.

Someone suggested combining the 'data' modules so that one data module was 
shared by different 'worker' modules.

Build that into the kernel rather than making it a module.

Call its functions 'inter_module_get' et al.

We seem to have returned to what I was suggesting in the first place.

Being able to do it completely in userspace would be neater, though.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
