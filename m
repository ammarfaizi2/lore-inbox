Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTGBAIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 20:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTGBAIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 20:08:24 -0400
Received: from ns.suse.de ([213.95.15.193]:39948 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264146AbTGBAIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 20:08:23 -0400
Date: Wed, 2 Jul 2003 02:22:44 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: James.Bottomley@steeleye.com, axboe@suse.de, grundler@parisc-linux.org,
       suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-Id: <20030702022244.030a8acc.ak@suse.de>
In-Reply-To: <20030701.170323.59686965.davem@redhat.com>
References: <1057077975.2135.54.camel@mulgrave>
	<20030702015701.6007ac26.ak@suse.de>
	<20030701.170323.59686965.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jul 2003 17:03:23 -0700 (PDT)
"David S. Miller" <davem@redhat.com> wrote:

>    From: Andi Kleen <ak@suse.de>
>    Date: Wed, 2 Jul 2003 01:57:01 +0200
>    
>    The K8 IOMMU cannot support this virtually contiguous thing. The reason
>    is that there is no guarantee that an entry in a sglist is a multiple
>    of page size. And the aperture can only map 4K sized chunks, like 
>    a CPU MMU. So e.g. when you have an sglist with multiple 1K entries there is 
> What do you mean?  You map only one 4K chunk, and this is used
> for all the sub-1K mappings.

How should this work when the 1K mappings are spread all over memory?

Maybe I'm missing something but from James description it sounds like the 
block layer assumes that it can pass in a sglist with arbitary elements 
and get it back remapped to continuous DMA addresses.

-Andi
