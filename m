Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318781AbSIPDdx>; Sun, 15 Sep 2002 23:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318783AbSIPDdx>; Sun, 15 Sep 2002 23:33:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16351 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318781AbSIPDdw>;
	Sun, 15 Sep 2002 23:33:52 -0400
Date: Sun, 15 Sep 2002 20:30:06 -0700 (PDT)
Message-Id: <20020915.203006.123845370.davem@redhat.com>
To: akropel1@rochester.rr.com
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Streaming DMA mapping question
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020914035112.GA14647@www.kroptech.com>
References: <20020913202150.GA24340@www.kroptech.com>
	<20020913.132842.97163812.davem@redhat.com>
	<20020914035112.GA14647@www.kroptech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Adam Kropelin <akropel1@rochester.rr.com>
   Date: Fri, 13 Sep 2002 23:51:13 -0400
   
   It seems that pci_dma_sync_*() transfers ownership in either direction.

That's a bug in the documentation, and no platform which has to care
about this area actually does what you imply.

A new interface needs to be added to transfer control in the other
direction.  pci_dma_sync_*() only handles transferring control from
device to CPU..

I know this makes drivers like eepro100 buggy, this was discussed
a month or two ago wrt. MIPS on linux-kernel, check the archives
for the thread.
