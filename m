Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbTGHWSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267822AbTGHWSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:18:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6046 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S267818AbTGHWQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:16:53 -0400
Date: Tue, 08 Jul 2003 15:23:14 -0700 (PDT)
Message-Id: <20030708.152314.115928676.davem@redhat.com>
To: grundler@parisc-linux.org
Cc: ak@suse.de, alan@lxorguk.ukuu.org.uk, James.Bottomley@SteelEye.com,
       axboe@suse.de, suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030708222545.GC6787@dsl2.external.hp.com>
References: <20030708213427.39de0195.ak@suse.de>
	<20030708.150433.104048841.davem@redhat.com>
	<20030708222545.GC6787@dsl2.external.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Grant Grundler <grundler@parisc-linux.org>
   Date: Tue, 8 Jul 2003 16:25:45 -0600

   On Tue, Jul 08, 2003 at 03:04:33PM -0700, David S. Miller wrote:
   >    Do you know a common PCI block device that would benefit from this
   >    (performs significantly better with short sg lists)? It would be
   >    interesting to test.
   >    
   > %10 to %15 on sym53c8xx devices found on sparc64 boxes.
   
   Which workload?

dbench type stuff, but that's a hard thing to test these days with
the block I/O schedulers changing so much.  Try to keep that part
constant in the with/vs/without VIO_VMERGE!=0 testing :)

