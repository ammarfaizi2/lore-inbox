Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265191AbUBIWQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 17:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUBIWQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 17:16:25 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:23715 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S265191AbUBIWQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 17:16:23 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: OOPS in 2.4.25-rc1 -- video1394
Mail-Copies-To: never
X-Face: ,MPrV]g0IX5D7rgJol{*%.pQltD?!TFg(`c8(2pkt-F0SLh(g3mIFYU1GYf]C/GuUTbr;cZ5y;3ALK%.OL8A.^.PW14e/,X-B?Nv}2a9\u-j0sSa
References: <873c9kebhw.fsf@mirexpress.internal.placard.fr.eu.org>
	<20040209175731.GN1042@phunnypharm.org>
From: Roland Mas <roland.mas@free.fr>
Date: Mon, 09 Feb 2004 23:16:19 +0100
In-Reply-To: <20040209175731.GN1042@phunnypharm.org> (Ben Collins's message
 of "Mon, 9 Feb 2004 12:57:31 -0500")
Message-ID: <873c9j3nm4.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins, 2004-02-09 12:57:31 -0500 :

[...]

> Looks to me like it is failing in alloc_dma_iso_ctx(), and then calling
> free_dma_iso_ctx() where it encounters some bad data. I can't see off
> hand where this might happen. Was there any message prior to this, like
> maybe a video1394 error message?

There were messages before that, yes.  Here come bits of my kern.log.
,----
| Feb  9 12:11:11 mirexpress kernel: mask: 8000000000000000 usage: 0000000000000000
| Feb  9 12:11:11 mirexpress kernel: video1394_0: Iso transmit DMA: 8 buffers of size 163840 allocated for a frame size 163840, each with 320 prgs
| Feb  9 12:11:11 mirexpress kernel: video1394_0: Iso context 0 talk on channel 63
| Feb  9 12:11:21 mirexpress kernel: video1394_0: Iso context 0 stop talking on channel 63
| Feb  9 12:12:51 mirexpress kernel: mask: 8000000000000000 usage: 0000000000000000
| Feb  9 12:12:51 mirexpress kernel: dma_region_alloc: vmalloc_32() failed
| Feb  9 12:12:51 mirexpress kernel: video1394_0: Failed to allocate dma buffer
| Feb  9 12:12:51 mirexpress kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004Feb  9 12:12:51 mirexpress kernel:  printing eip:
| Feb  9 12:12:51 mirexpress kernel: fcd81136
| Feb  9 12:12:51 mirexpress kernel: *pde = 00000000
| Feb  9 12:12:51 mirexpress kernel: Oops: 0002
| Feb  9 12:12:51 mirexpress kernel: CPU:    0
| Feb  9 12:12:51 mirexpress kernel: EIP:    0010:[<fcd81136>]    Not tainted
| Feb  9 12:12:51 mirexpress kernel: EFLAGS: 00210246
| [snip]
`----
The entries until 12:11:21 are when I used dvconnect (which worked).
So there are indeed three lines before the actual oops, including two
that look like error messages.

  If there's anything else I can povide, just say so, I just can't
think of anything.

  Thanks,

Roland.
-- 
Roland Mas

A man walks into a bar.
Bang.
