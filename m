Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTANPbG>; Tue, 14 Jan 2003 10:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbTANPbF>; Tue, 14 Jan 2003 10:31:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10917 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263215AbTANPbE>;
	Tue, 14 Jan 2003 10:31:04 -0500
Date: Tue, 14 Jan 2003 07:30:23 -0800 (PST)
Message-Id: <20030114.073023.89921980.davem@redhat.com>
To: James.Bottomley@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Update the generic DMA API to take GFP_ flags on
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200301141530.h0EFUGH02371@localhost.localdomain>
References: <200301141530.h0EFUGH02371@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Bottomley <James.Bottomley@steeleye.com>
   Date: Tue, 14 Jan 2003 10:30:15 -0500

   A GFP_KERNEL request is safely implemented as GFP_ATOMIC as long as the caller 
   checks return for NULL.  for dma_alloc_coherent return checking is a 
   requirement because the system may return NULL anyway if it is out of mappings 
   even with a GFP_KERNEL flag.
   
Now what about the corollary, a platform that needs
to sleep to setup the cpu mapings in a race-free manner?

It could not ever honor GFP_ATOMIC in that case.
