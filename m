Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbTL2TL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbTL2TL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:11:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265356AbTL2TK6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:10:58 -0500
Message-ID: <3FF07C2F.6080408@pobox.com>
Date: Mon, 29 Dec 2003 14:10:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Sirotkin, Alexander" <demiurg@ti.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: network driver that uses skb destructor
References: <3FF05C27.5030706@ti.com>
In-Reply-To: <3FF05C27.5030706@ti.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sirotkin, Alexander wrote:
> I would like to write a network driver that uses DMA and manages it's 
> own memory.
> 
> The most common approach (in RX) seem to be to allocate the memory for 
> DMA transfer using dev_alloc_skb(), get the HW DMA engine to transfer 
> the packet into this skb buffer and later free it using dev_kfree_skb().
> 
> For various reasons (mainly to support legacy source code) I would like 
> to allocate and free the buffer using my own functions. Theoretically, I 
> could get away by using skb->destructor.


This won't work, since you cannot chain skb destructors...

	Jeff



