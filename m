Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267195AbSLEC7I>; Wed, 4 Dec 2002 21:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbSLEC7I>; Wed, 4 Dec 2002 21:59:08 -0500
Received: from host194.steeleye.com ([66.206.164.34]:37130 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267195AbSLEC7H>; Wed, 4 Dec 2002 21:59:07 -0500
Message-Id: <200212050306.gB536bV05710@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Miles Bader <miles@gnu.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from Miles Bader <miles@lsi.nec.co.jp> 
   of "05 Dec 2002 11:31:10 +0900." <buou1htryc1.fsf@mcspd15.ucom.lsi.nec.co.jp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Dec 2002 21:06:37 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

miles@lsi.nec.co.jp said:
> My thinking was that a driver might want to do things like --
>   if (dma_addr_is_consistent (some_funky_addr)) {
>     do it quickly;
>   } else
>     do_it_the_slow_way (some_funky_addr);
> in other words, something besides just calling the sync functions, in
> the case where the memory was consistent. 

Actually, I did code an api for that case, it's the dma_get_conformance() one 
which tells you the consistency type of memory that you actually got, so if 
you really need to tell the difference, you can.

James



