Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTFGHL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 03:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTFGHL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 03:11:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36995 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262610AbTFGHL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 03:11:56 -0400
Date: Sat, 07 Jun 2003 00:19:48 -0700 (PDT)
Message-Id: <20030607.001948.38705799.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: manfred@colorfullife.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16097.37454.827982.278024@napali.hpl.hp.com>
References: <200306062013.h56KDcLe026713@napali.hpl.hp.com>
	<20030606.234401.104035537.davem@redhat.com>
	<16097.37454.827982.278024@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Sat, 7 Jun 2003 00:20:46 -0700

   >>>>> On Fri, 06 Jun 2003 23:44:01 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:
   
     DaveM>    This sounds all very dramatic, but try as I might, all I
     DaveM> find is three places where PCI_DMA_BUS_IS_PHYS is used:
   
     DaveM> Fix your grep,
   
   What am I missing?
   
Sorry, I was meaning to mention BIO_VMERGE_BOUNDARY which works in
concert with PCI_DMA_BUS_IS_PHYS.  You really have to set it
accurately to get the most out of the block layer's ability to
take advantage of IOMMUs.
