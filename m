Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTBSWnQ>; Wed, 19 Feb 2003 17:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbTBSWnQ>; Wed, 19 Feb 2003 17:43:16 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:31976
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S262289AbTBSWnP>; Wed, 19 Feb 2003 17:43:15 -0500
Date: Wed, 19 Feb 2003 17:53:02 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: "David S. Miller" <davem@redhat.com>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>,
       <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
In-Reply-To: <20030219.142952.27404695.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0302191750580.29393-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, David S. Miller wrote:

> Yes true, storing the two consequetive 32-bit values is better
> for store buffer compression of the cpu.  Using memset is much
> more inefficient because you push the full set of data once
> then you push non-compressible stores to the same data through
> the cpu.
> 
> I'm not talking out of my ass, I've measured this.

So is the current wisdom something like "always treat dma_addr_t as a u64
and be happy"?

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

