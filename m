Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317917AbSGWDCN>; Mon, 22 Jul 2002 23:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317924AbSGWDCN>; Mon, 22 Jul 2002 23:02:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21930 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317917AbSGWDCL>;
	Mon, 22 Jul 2002 23:02:11 -0400
Date: Mon, 22 Jul 2002 19:54:26 -0700 (PDT)
Message-Id: <20020722.195426.14578063.davem@redhat.com>
To: thunder@ngforever.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another DMA question
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0207222035420.3241-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0207222035420.3241-100000@hawkeye.luckynet.adm>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thunder from the hill <thunder@ngforever.de>
   Date: Mon, 22 Jul 2002 20:38:51 -0600 (MDT)

   How can I get the _real_ address of a pci_map_single area, if needed? The 
   thing bus_to_virt() did, basically. My problem is that I have code which 
   changed the first byte of a buffer of stuff read via DMA, and I can't 
   because the previous user did bus_to_virt() to get a pointer into that. I 
   don't know how to get another pointer.
   
   After all the confusion, is the question clear?
   
You need to keep track of the back translations yourself.  See how the
various net drivers do this by keeping a RX and TX ring of the SKB
buffers mapped into the various rings.
