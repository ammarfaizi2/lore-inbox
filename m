Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266077AbTGISkl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268438AbTGISkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:40:40 -0400
Received: from ns.suse.de ([213.95.15.193]:31502 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266077AbTGISkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:40:39 -0400
Date: Wed, 9 Jul 2003 20:55:15 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: grundler@parisc-linux.org, alan@lxorguk.ukuu.org.uk,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-Id: <20030709205515.716a2f3a.ak@suse.de>
In-Reply-To: <20030708.152314.115928676.davem@redhat.com>
References: <20030708213427.39de0195.ak@suse.de>
	<20030708.150433.104048841.davem@redhat.com>
	<20030708222545.GC6787@dsl2.external.hp.com>
	<20030708.152314.115928676.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jul 2003 15:23:14 -0700 (PDT)
"David S. Miller" <davem@redhat.com> wrote:

>    From: Grant Grundler <grundler@parisc-linux.org>
>    Date: Tue, 8 Jul 2003 16:25:45 -0600
> 
>    On Tue, Jul 08, 2003 at 03:04:33PM -0700, David S. Miller wrote:
>    >    Do you know a common PCI block device that would benefit from this
>    >    (performs significantly better with short sg lists)? It would be
>    >    interesting to test.
>    >    
>    > %10 to %15 on sym53c8xx devices found on sparc64 boxes.
>    
>    Which workload?
> 
> dbench type stuff, but that's a hard thing to test these days with
> the block I/O schedulers changing so much.  Try to keep that part
> constant in the with/vs/without VIO_VMERGE!=0 testing :)

With MPT-Fusion and reaim "new dbase" load it seems to be slightly faster
with forced IOMMU merging on Opteron, but the differences are quite small (~4%) and could
be measurement errors.

-Andi
