Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265962AbTGHCIP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 22:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbTGHCIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 22:08:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6039 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265962AbTGHCIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 22:08:14 -0400
Date: Mon, 07 Jul 2003 19:14:38 -0700 (PDT)
Message-Id: <20030707.191438.71104854.davem@redhat.com>
To: ak@suse.de
Cc: alan@lxorguk.ukuu.org.uk, grundler@parisc-linux.org,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030703212415.GA30277@wotan.suse.de>
References: <20030702235619.GA21567@wotan.suse.de>
	<1057263988.21508.18.camel@dhcp22.swansea.linux.org.uk>
	<20030703212415.GA30277@wotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Thu, 3 Jul 2003 23:24:15 +0200

   But of course it doesn't help much in practice because all the interesting
   block devices support DAC anyways and the IOMMU is disabled for that.
   
Platform dependant.  SAC DMA transfers are faster on sparc64 so
we only allow the device to specify a 32-bit DMA mask successfully.

And actually, I would recommend other platforms that have a IOMMU do
this too (unless there is some other reason not to) since virtual
merging causes less scatter-gather entries to be used in the device
and thus you can stuff more requests into it.
