Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTGBAOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 20:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTGBAOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 20:14:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44762 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264087AbTGBAOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 20:14:14 -0400
Date: Tue, 01 Jul 2003 17:21:36 -0700 (PDT)
Message-Id: <20030701.172136.48497962.davem@redhat.com>
To: ak@suse.de
Cc: James.Bottomley@steeleye.com, axboe@suse.de, grundler@parisc-linux.org,
       suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030702022244.030a8acc.ak@suse.de>
References: <20030702015701.6007ac26.ak@suse.de>
	<20030701.170323.59686965.davem@redhat.com>
	<20030702022244.030a8acc.ak@suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Wed, 2 Jul 2003 02:22:44 +0200

   On Tue, 01 Jul 2003 17:03:23 -0700 (PDT)
   "David S. Miller" <davem@redhat.com> wrote:
   
   > What do you mean?  You map only one 4K chunk, and this is used
   > for all the sub-1K mappings.
   
   How should this work when the 1K mappings are spread all over memory?
   
   Maybe I'm missing something but from James description it sounds like the 
   block layer assumes that it can pass in a sglist with arbitary elements 
   and get it back remapped to continuous DMA addresses.
   
It assumes it can pass in an sglist with arbitrary "virtually
contiguous" elements and get back a continuous DMA address.

The BIO_VMERGE_BOUNDRY defines the IOMMU page size and therefore
what "virtually contiguous" means.
