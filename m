Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSL1Sbz>; Sat, 28 Dec 2002 13:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSL1Sbz>; Sat, 28 Dec 2002 13:31:55 -0500
Received: from host194.steeleye.com ([66.206.164.34]:61456 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261721AbSL1Sbz>; Sat, 28 Dec 2002 13:31:55 -0500
Message-Id: <200212281840.gBSIeBB02996@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Manfred Spraul <manfred@colorfullife.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation 
In-Reply-To: Message from Manfred Spraul <manfred@colorfullife.com> 
   of "Sat, 28 Dec 2002 19:25:07 +0100." <3E0DEC83.2070900@colorfullife.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 12:40:11 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

manfred@colorfullife.com said:
> If multiple kmalloc buffers fit into one cacheline, then it can happen
>  all the time. But the smallest kmalloc buffer is 64 bytes [assuming
> page  size > 4096].

Actually, I did forget to mention that on parisc non-coherent, the minimum 
kmalloc allocation is the cache line width, so that problem cannot occur.

Hmm, perhaps that is an easier (and faster) approach to fixing the problems on 
non-coherent platforms?

James


