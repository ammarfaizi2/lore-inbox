Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTGAX4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 19:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbTGAX4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 19:56:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32986 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263279AbTGAX4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 19:56:01 -0400
Date: Tue, 01 Jul 2003 17:03:23 -0700 (PDT)
Message-Id: <20030701.170323.59686965.davem@redhat.com>
To: ak@suse.de
Cc: James.Bottomley@steeleye.com, axboe@suse.de, grundler@parisc-linux.org,
       suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030702015701.6007ac26.ak@suse.de>
References: <1057077975.2135.54.camel@mulgrave>
	<20030702015701.6007ac26.ak@suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Wed, 2 Jul 2003 01:57:01 +0200
   
   The K8 IOMMU cannot support this virtually contiguous thing. The reason
   is that there is no guarantee that an entry in a sglist is a multiple
   of page size. And the aperture can only map 4K sized chunks, like 
   a CPU MMU. So e.g. when you have an sglist with multiple 1K entries there is 
What do you mean?  You map only one 4K chunk, and this is used
for all the sub-1K mappings.

I can only map 8K sized chunks on the sparc64 IOMMU and this
works perfectly fine.
