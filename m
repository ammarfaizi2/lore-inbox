Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282920AbRLMA0w>; Wed, 12 Dec 2001 19:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282934AbRLMA0m>; Wed, 12 Dec 2001 19:26:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27527 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282920AbRLMA0Z> convert rfc822-to-8bit;
	Wed, 12 Dec 2001 19:26:25 -0500
Date: Wed, 12 Dec 2001 16:26:03 -0800 (PST)
Message-Id: <20011212.162603.28785873.davem@redhat.com>
To: groudier@free.fr
Cc: andrea@suse.de, axboe@suse.de, gibbs@scsiguy.com, LB33JM16@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011212210923.I642-100000@gerard>
In-Reply-To: <20011212231936.Q4801@athlon.random>
	<20011212210923.I642-100000@gerard>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gérard Roudier <groudier@free.fr>
   Date: Wed, 12 Dec 2001 21:24:59 +0100 (CET)
   
   A N% loss for the 99% case in order to support the 1% is close to N%
   loss. So, each time we bloat or complexify the code with no relevance for
   the average case, the overall difference cannot be a win.

Do you know, you can use this N% loss to implement handling of the
very problem you have wrt. sym53c8xx hw bugs? :-)

To be honest all the machinery to handle the problems you have
described are there today, even with IOMMU's present.  The generic
block layer today knows when IOMMU is being used, it knows what kind
of coalescing can and will be done by the IOMMU support code (via
DMA_CHUNK_SIZE), and therefore it is capable of adhering to any
restrictions you care to describe to the block layer.

It's only a matter of coding on Jens's part :-)
