Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272746AbRIGPyB>; Fri, 7 Sep 2001 11:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272742AbRIGPxw>; Fri, 7 Sep 2001 11:53:52 -0400
Received: from mx9.port.ru ([194.67.57.19]:15542 "EHLO mx9.port.ru")
	by vger.kernel.org with ESMTP id <S272734AbRIGPxh>;
	Fri, 7 Sep 2001 11:53:37 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109072016.f87KG9r06406@vegae.deep.net>
Subject: Re: Recent kernels sound crash  solution found?
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 7 Sep 2001 20:16:08 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15fNy1-0001uy-00@the-village.bc.nu> from "Alan Cox" at Sep 07, 2001 04:54:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Alan Cox wrote:"
> 
> >          * Now loop until we get a free buffer. Try to get smaller buffer if
> >          * it fails. Don't accept smaller than 8k buffer for performance
> >          * reasons.
> >          */
> >     ===>  _here_ is a dead-loop  <===
> >         while (start_addr == NULL && dmap->buffsize > PAGE_SIZE) {
> 
> It terminates when dmap->bufsise hits  page size
> >                 start_addr = (char *) __get_free_pages(GFP_ATOMIC|GFP_DMA, sz);
> >                 if (start_addr == NULL)
> >                         dmap->buffsize /= 2;
> 
> I see no bug
> 
     Ahh.. yes. Sorry for this one. Comment was so obvious.

regards, Sam
