Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266277AbUA2Ari (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 19:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266278AbUA2Ari
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 19:47:38 -0500
Received: from intra.cyclades.com ([64.186.161.6]:3480 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S266277AbUA2Arf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 19:47:35 -0500
Date: Wed, 28 Jan 2004 22:06:25 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Christoph Hellwig <hch@infradead.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PC300 update
In-Reply-To: <20040128212115.A2027@infradead.org>
Message-ID: <Pine.LNX.4.58L.0401282203170.2163@logos.cnet>
References: <Pine.LNX.4.58L.0401281741120.2088@logos.cnet>
 <20040128212115.A2027@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Christoph!

On Wed, 28 Jan 2004, Christoph Hellwig wrote:

> > - Mark pci_device_id list with __devinitdata
>
> This is bogus and can crash the kernel if you're unlucky.

Other wan drivers are doing the same:

[marcelo@logos wan]$ grep __devinitdata *
farsync.c:static char *type_strings[] __devinitdata = {
wanxl.c:static struct pci_device_id wanxl_pci_tbl[] __devinitdata = {

I believe a handful of others are using "__devinitdata". How can the
kernel crash because of this? Who will try to touch the data?

> > - Add #ifdef DEBUG around debug printk()
>
> What about dprintk or friends instead?

Yes I will change to dev_dbg() as Greg suggested. Thanks!
