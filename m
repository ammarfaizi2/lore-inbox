Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbSLaXXW>; Tue, 31 Dec 2002 18:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSLaXXW>; Tue, 31 Dec 2002 18:23:22 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:52887 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264859AbSLaXXV>; Tue, 31 Dec 2002 18:23:21 -0500
Date: Tue, 31 Dec 2002 15:35:28 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Message-id: <3E1229C0.2010000@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212312202.OAA10841@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:

> 	I think that the term "pool" is more descriptively used by
> mempool and more misleadningly used by the pci_pool code, as there is
> no guaranteed pool being reserved in the pci_pool code.  Alas, I don't
> have a good alternative term to suggest at the moment.

FWIW pci_pool predates mempool by quite a bit (2.4.early vs 2.5.later),
and I don't think I've noticed any correlation between allocation using
the "pool" word and reserving memory ... so I thought it was "mempool"
that clashed.  No big deal IMO, "all the good words are taken".

I seem to recall it was a portability issue that made pci_pool never
release pages once it allocates them ... some platform couldn't cope
with pci_free_consistent() being called in_interrupt().  In practice
that seems to have been a good enough reservation scheme so far.

- Dave


