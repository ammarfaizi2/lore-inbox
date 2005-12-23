Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161137AbVLWXui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161137AbVLWXui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 18:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbVLWXui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 18:50:38 -0500
Received: from mx.pathscale.com ([64.160.42.68]:47750 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161137AbVLWXui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 18:50:38 -0500
Subject: Re: [RFC] [PATCH] Add memcpy32 function
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matt Mackall <mpm@selenic.com>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051223174228.GA29679@infradead.org>
References: <1135301759.4212.76.camel@serpentine.pathscale.com>
	 <20051223024943.GC27537@redhat.com> <20051223171628.GP3356@waste.org>
	 <20051223174228.GA29679@infradead.org>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 15:50:21 -0800
Message-Id: <1135381822.26606.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 17:42 +0000, Christoph Hellwig wrote:

> Actually I think memcpy32 is not the thing pathscale wants.  They want
> memcpy_{to,from}_io32, because memcpy32 wouldn't be allowed to operate
> on I/O mapped memory.  I'd say back to the drawingboard.

Fair enough.  I'll follow Matt's suggestion of iowrite32_copy and
ioread32_copy, in that case, and put them in asm-generic/iomap.h.

> And to pathscale:  please get your driver __iomem and endianess annotated
> before sending out further core patches, I'm pretty sure getting those
> things fixed will shed some light on the actual requirements.

OK, will do.

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>

