Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291473AbSBMKLC>; Wed, 13 Feb 2002 05:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291492AbSBMKKx>; Wed, 13 Feb 2002 05:10:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60934 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291473AbSBMKKi>; Wed, 13 Feb 2002 05:10:38 -0500
Subject: Re: [patch] printk and dma_addr_t
To: davem@redhat.com (David S. Miller)
Date: Wed, 13 Feb 2002 10:23:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, akpm@zip.com.au, linux-kernel@vger.kernel.org,
        ralf@uni-koblenz.de
In-Reply-To: <20020213.013557.74564240.davem@redhat.com> from "David S. Miller" at Feb 13, 2002 01:35:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16awZq-0004s4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: Wed, 13 Feb 2002 09:40:44 +0000 (GMT)
> 
>    Vomit. How about adding a dma_addr_t %code to the printk function ?
> 
> And gcc will discover this via what?  Osmosis perhaps? :-)

Yeah, seems gcc is a bit lacking in its overclever printf handlers. It
lacks the ability to declare additional non standard % code - despite the
fact glibc itself expands on the standard

       glibc 2.0 adds conversion characters C and S.

       glibc  2.1  adds  length modifiers hh,j,t,z and conversion
       characters a,A.

       glibc 2.2 adds the conversion character F with C99  seman-
       tics, and the flag character I.

So how do they modify the printf format rules in gcc ?
