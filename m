Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWA0HKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWA0HKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 02:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWA0HKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 02:10:49 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:50389 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751431AbWA0HKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 02:10:48 -0500
Date: Fri, 27 Jan 2006 09:10:47 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 8/9] slab - Add *_mempool slab variants
In-Reply-To: <43D94FC1.4050708@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0601270910000.14394@sbz-30.cs.Helsinki.FI>
References: <20060125161321.647368000@localhost.localdomain> 
 <1138218020.2092.8.camel@localhost.localdomain>
 <84144f020601252341k62c0c6fck57f3baa290f4430@mail.gmail.com>
 <43D94FC1.4050708@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Matthew Dobson wrote:
> I decided that using a whole page allocator would be the easiest way to
> cover the most common uses of slab/kmalloc, but your idea is very
> interesting.  My immediate concern would be trying to determine, at kfree()
> time, what was allocated by the slab allocator and what was allocated by
> the critical pool.  I will give this approach more thought, as the idea of
> completely separating the critical pool and slab allocator is attractive.

I think you can use PageSlab for that.

			Pekka
