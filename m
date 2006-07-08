Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWGHUsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWGHUsO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWGHUsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:48:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50923
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030365AbWGHUsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:48:13 -0400
Date: Sat, 08 Jul 2006 13:48:42 -0700 (PDT)
Message-Id: <20060708.134842.78364391.davem@davemloft.net>
To: hch@lst.de
Cc: akpm@osdl.org, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] disallow modular binfmt_elf32
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060708180554.GB7034@lst.de>
References: <20060708180554.GB7034@lst.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat, 8 Jul 2006 20:05:54 +0200

> Currently most architectures either always build binfmt_elf32 in the
> kernel image or make it a boolean option.  Only sparc64 and s390 allow
> to build it modularly.  This patch turns the option into a boolean
> aswell because elf requires various symbols that shouldn't be available
> to modules.  The most urgent one is tasklist_lock whos export this patch
> series kills, but there are others like force_sgi aswell.
> 
> Note that sparc doesn't allow a modular 32bit a.out handler either, and
> that would be the more useful case as only few people want 32bit sunos
> compatibility and 99.9% of all sparc64 users need 32bit linux native elf
> support.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yeah, I'm ok with this:

Signed-off-by: David S. Miller <davem@davemloft.net>
