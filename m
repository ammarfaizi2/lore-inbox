Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbTFFG6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 02:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265365AbTFFG6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 02:58:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53736 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265362AbTFFG6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 02:58:48 -0400
Date: Fri, 06 Jun 2003 00:08:48 -0700 (PDT)
Message-Id: <20030606.000848.38709837.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: manfred@colorfullife.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16096.15034.490916.644970@napali.hpl.hp.com>
References: <16096.14281.621282.67906@napali.hpl.hp.com>
	<20030605.234526.23012957.davem@redhat.com>
	<16096.15034.490916.644970@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Thu, 5 Jun 2003 23:54:50 -0700

   >>>>> On Thu, 05 Jun 2003 23:45:26 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

     > David, what is blk_max_low_pfn set to on your ia64 systems?
   
   max_low_pfn, which is going to be the pfn of some page > 4GB (for
   machines with a sufficient amount of memory).

Right, but see my other email, you need to see PCI_DMA_BUS_IS_PHYS
properly.  This tells the block layer if you're IOMMU or not.
