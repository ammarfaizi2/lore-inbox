Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154727AbPGLO5v>; Mon, 12 Jul 1999 10:57:51 -0400
Received: by vger.rutgers.edu id <S154742AbPGLNZW>; Mon, 12 Jul 1999 09:25:22 -0400
Received: from nexusel.demon.co.uk ([158.152.30.195]:19552 "EHLO globe.nexus.co.uk") by vger.rutgers.edu with ESMTP id <S155211AbPGLLwm>; Mon, 12 Jul 1999 07:52:42 -0400
X-Mailer: exmh version 2.0.2 2/24/98 (debian) 
To: Alan Arolovitch <alan@gravity-cs.com>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: DMA bus-master writes & CPU cache question 
In-reply-to: Your message of "Mon, 12 Jul 1999 02:07:52 +0300." <199907112307.CAA18191@gravity-cs.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Jul 1999 12:51:37 +0100
From: Philip Blundell <pb@nexus.co.uk>
Message-Id: <E113ecT-0006RE-00@fountain.nexus.co.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

>Should CPU cache affect reading data from the DMA area, i.e.
>may some buffering effect or data inconherence appear? If so, 
>what are the options?

This depends on your architecture.  Intel platforms are fully DMA coherent; 
the chipset snoops on DMA cycles and flushes the cache as required to maintain 
a consistent view.  On some other machines this is not the case and you must 
deal with the caches by hand (see, for example, 
include/asm-arm/proc-armv/io.h).

p.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
