Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSLaRRe>; Tue, 31 Dec 2002 12:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSLaRRe>; Tue, 31 Dec 2002 12:17:34 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:36855 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264630AbSLaRRd>; Tue, 31 Dec 2002 12:17:33 -0500
Date: Tue, 31 Dec 2002 09:32:11 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E11D49B.80509@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212311636.gBVGa8t02091@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> How about the attached as the basis for a generic coherent memory pool 
> implementation.  It basically leverages pci/pool.c to be more generic, and 
> thus makes use of well tested code.

I'd still rather have configuration completely eliminate that particular
pool allocator on the platforms (most, by volume) that don't need it,
in favor of the slab code ... which is not only well-tested, but also
has had a fair amount of cross-platform performance work done on it.


> Obviously, as a final tidy up, pci/pool.c should probably be moved to 
> base/pool.c with compile options for drivers that want it.

I'd have no problems with making it even more generic, and moving it.

Though "compile options" doesn't sound right, unless you mean letting
arch-specific code choose whether to use that or the slab allocator.

- Dave


