Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271565AbRHPMZR>; Thu, 16 Aug 2001 08:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271566AbRHPMZH>; Thu, 16 Aug 2001 08:25:07 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:28430 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S271565AbRHPMYt>;
	Thu, 16 Aug 2001 08:24:49 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [patch] zero-bounce highmem I/O
Date: 16 Aug 2001 12:14:40 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9nne9g.8eb.kraxel@bytesex.org>
In-Reply-To: <20010815.070204.39155321.davem@redhat.com> <20010815.072548.48531893.davem@redhat.com> <20010816135150.X4352@suse.de> <20010816.045642.116348743.davem@redhat.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 997964080 8652 127.0.0.1 (16 Aug 2001 12:14:40 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  What if my scsi controller's pci DMA mask is 0x7fffffff or something
>  like this?  You don't know at the generic layer, and you must provide
>  some way for the block device to indicate stuff like this to you.

While we are at it:  Is there some portable way to figure whenever I can
do a PCI DMA transfer to some page?  On ia32 I can simply look at the
physical address and if it is behind 4G it doesn't work for 32bit PCI
devices.  But I think that is not true for architectures which have a
iommu ...

  Gerd

