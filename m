Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272741AbRIGPuv>; Fri, 7 Sep 2001 11:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272734AbRIGPul>; Fri, 7 Sep 2001 11:50:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59655 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272733AbRIGPua>; Fri, 7 Sep 2001 11:50:30 -0400
Subject: Re: Recent kernels sound crash  solution found?
To: _deepfire@mail.ru (Samium Gromoff)
Date: Fri, 7 Sep 2001 16:54:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200109072009.f87K92G06330@vegae.deep.net> from "Samium Gromoff" at Sep 07, 2001 08:09:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15fNy1-0001uy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>          * Now loop until we get a free buffer. Try to get smaller buffer if
>          * it fails. Don't accept smaller than 8k buffer for performance
>          * reasons.
>          */
>     ===>  _here_ is a dead-loop  <===
>         while (start_addr == NULL && dmap->buffsize > PAGE_SIZE) {

It terminates when dmap->bufsise hits  page size
>                 start_addr = (char *) __get_free_pages(GFP_ATOMIC|GFP_DMA, sz);
>                 if (start_addr == NULL)
>                         dmap->buffsize /= 2;

I see no bug
