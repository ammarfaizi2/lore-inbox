Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262942AbSIPVAB>; Mon, 16 Sep 2002 17:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262957AbSIPVAB>; Mon, 16 Sep 2002 17:00:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61414 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262942AbSIPVAB>;
	Mon, 16 Sep 2002 17:00:01 -0400
Date: Mon, 16 Sep 2002 13:56:06 -0700 (PDT)
Message-Id: <20020916.135606.107746701.davem@redhat.com>
To: lists@mdiehl.de
Cc: akropel1@rochester.rr.com, linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Streaming DMA mapping question
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0209162144550.6230-100000@notebook.diehl.home>
References: <20020915.203006.123845370.davem@redhat.com>
	<Pine.LNX.4.21.0209162144550.6230-100000@notebook.diehl.home>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Martin Diehl <lists@mdiehl.de>
   Date: Mon, 16 Sep 2002 23:06:35 +0200 (CEST)
   
   Wasn't there a patch submitted which suggested to add pci_dma_prep_*()
   calls in order to sync the cpu-driven changes back to the bus? I'm asking
   because I'm dealing with a driver that needs to reuse streaming pci maps.
   
Yes, basically this is what must happen.

If someone would code up a patch that includes the MIPS
implementation, adds NOP implementations to every other asm/pci.h file
and updates the Documentation/DMA-mapping.txt file appropriately,
I'll probably just apply the patch and merge it upstream immediately.

I don't have time to work on this patch right now and I don't know how
the MIPS part should be implemented so...
