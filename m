Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271418AbRHPOyJ>; Thu, 16 Aug 2001 10:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271417AbRHPOx7>; Thu, 16 Aug 2001 10:53:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60178 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271408AbRHPOxu>; Thu, 16 Aug 2001 10:53:50 -0400
Subject: Re: [patch] zero-bounce highmem I/O
To: davem@redhat.com (David S. Miller)
Date: Thu, 16 Aug 2001 15:56:21 +0100 (BST)
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 16, 2001 07:15:19 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XOZJ-0005LW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is video layer, and the video layer should be helping along with
> these sorts of issues.

Linus refused to let make make the vmalloc helpers generic code, thats
why we have 8 or 9 different copies some containing old bugs

> void video_pci_put_user_pages(struct pci_dev *pdev,
> 			      struct scatterlist *sg,
> 			      int npages);

Why video_pci. WHy is this even video related. This is a generic issue

> In fact, this isn't even a video layer issue, and the kernel
> ought to provide my suggested interfaces in some generic
> place.

Then we agree on that
