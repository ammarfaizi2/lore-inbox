Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129765AbQLUQgG>; Thu, 21 Dec 2000 11:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130247AbQLUQfz>; Thu, 21 Dec 2000 11:35:55 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26126 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129765AbQLUQfk>; Thu, 21 Dec 2000 11:35:40 -0500
Subject: Re: [Patch] performance enhancement for simple_strtoul
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Thu, 21 Dec 2000 16:07:33 +0000 (GMT)
Cc: ddata@gate.net (Steve Grubb),
        linux-kernel@vger.kernel.org (Linux-Kernel mailing list)
In-Reply-To: <20001221101656.B8388@emma1.emma.line.org> from "Matthias Andree" at Dec 21, 2000 10:16:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1498Fj-0003F9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 20 Dec 2000, Steve Grubb wrote:
> 
> > +                        while (isdigit(c)) {
> > +                                result = (result*10) + (c & 0x0f);
> > +                                c = *(++cp);
> > +                        }
> 
> x * 10 can be written as:
> 
> (x << 2 + x) << 1   = (4x+x) * 2
> (x << 3) + (x << 1) = 8x + 2x 

Since when has printk been performance critical. It isnt worth microoptimising
(or in your case for some cpus micropessimising) that stuff. Besides, gcc should
work it out if its worth doing

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
