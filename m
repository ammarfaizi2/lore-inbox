Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTBSSBP>; Wed, 19 Feb 2003 13:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268959AbTBSSBP>; Wed, 19 Feb 2003 13:01:15 -0500
Received: from host194.steeleye.com ([66.206.164.34]:2567 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S263366AbTBSSBO>; Wed, 19 Feb 2003 13:01:14 -0500
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ion Badulescu <ionut@badula.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Feb 2003 13:11:07 -0500
Message-Id: <1045678275.2033.37.camel@mulgrave>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> 3. use run-time checks all over the place, of the 
> "sizeof(dma_addr_t)==sizeof(u64)" kind, which adds unnecessary
> overhead to 
> all platforms.

Actually, these aren't technically run time checks.  Although the cpp
can't be used for sizeof(), the compiler (at least gcc) does seem to
have enough sense to optimise away if(..) branches it has enough
information to know won't be taken at compile time.

As long as this optimisation works, I think the if(sizeof(..)) checks
are fine for this.

James



