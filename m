Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbTGCUPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 16:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbTGCUPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 16:15:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13465
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265375AbTGCUPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 16:15:12 -0400
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       James Bottomley <James.Bottomley@SteelEye.com>, axboe@suse.de,
       davem@redhat.com, suparna@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
In-Reply-To: <20030702235619.GA21567@wotan.suse.de>
References: <1057077975.2135.54.camel@mulgrave>
	 <20030702015701.6007ac26.ak@suse.de>
	 <20030702165510.GC11739@dsl2.external.hp.com>
	 <1057180598.20318.32.camel@dhcp22.swansea.linux.org.uk>
	 <20030702235619.GA21567@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057263988.21508.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jul 2003 21:26:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-03 at 00:56, Andi Kleen wrote:
> > 1.	We allocate pages in reverse order so most merges cant occur
> 
> I added an printk and I get quite a lot of merges during bootup
> with normal IDE.
> 
> (sometimes 12+ segments) 

Thats merging adjacent blocks with non adjacent page targets using the
IOMMU right - I was doing mergign without an IOMMU which is a little
different and turns out to be a waste of cpu

