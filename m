Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTJFWxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 18:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTJFWxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 18:53:23 -0400
Received: from intra.cyclades.com ([64.186.161.6]:11440 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261626AbTJFWxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 18:53:21 -0400
Date: Mon, 6 Oct 2003 19:56:07 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Andriy Rysin <arysin@bcsii.net>
Cc: linux-kernel@vger.kernel.org, <sct@redhat.com>,
       Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ext3 crash with 2.4.22: Assertion failure in journal_forget_R10d91946()
In-Reply-To: <3F7C8742.5090907@bcsii.net>
Message-ID: <Pine.LNX.4.44.0310061946290.2403-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andriy, 

On Thu, 2 Oct 2003, Andriy Rysin wrote:

> I am having crashes on ext3 with 2.4.22 kernel. System was up for 8 
> days. I am not sure I can reproduce it real quick but we've seen it 
> occasionly on 2.4.20 for about several months and after we updated to 
> 2.4.22 it's here again.
> 
> please CC me if you answer or need more information.
> 
> 
> the log looks like this:
> 
> Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
> ext3_free_blocks: Freeing blocks not in datazone - bloc
> k = 2907885836, count = 1
> Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
> ext3_free_blocks: Freeing blocks not in datazone - bloc
> k = 1660415916, count = 1
> Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
> ext3_free_blocks: Freeing blocks not in datazone - bloc
> k = 1438298218, count = 1
> Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
> ext3_free_blocks: Freeing blocks not in datazone - bloc
> k = 4209573569, count = 1
> Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
> ext3_free_blocks: Freeing blocks not in datazone - bloc
> k = 2918065562, count = 1
> ......
> Sep 29 21:05:18 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
> ext3_free_blocks: bit already cleared for block 5970190
> ......
> Oct  2 00:43:53 dunne-demo kernel: hda: dma_timer_expiry: dma status == 0x20
> Oct  2 00:43:53 dunne-demo kernel: hda: timeout waiting for DMA
> Oct  2 00:43:53 dunne-demo kernel: hda: timeout waiting for DMA
> Oct  2 00:43:53 dunne-demo kernel: hda: (__ide_dma_test_irq) called 

You are getting DMA timeouts and such. Try turning off the DMA.

But anyway the ext3 fs errors shouldnt happen I guess. Andrew, Stephen?

