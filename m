Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318027AbSGWLLy>; Tue, 23 Jul 2002 07:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318028AbSGWLLy>; Tue, 23 Jul 2002 07:11:54 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:10968 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S318027AbSGWLLx>; Tue, 23 Jul 2002 07:11:53 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [never mind] kiobufs and highmem
Date: 23 Jul 2002 11:17:33 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnajqeqd.2q8.kraxel@bytesex.org>
References: <ic9gju44p7ukriuv4etl0tdc5f6uf5s08m@4ax.com> <20020720003918.G758@nightmaster.csn.tu-chemnitz.de>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1027423053 2926 127.0.0.1 (23 Jul 2002 11:17:33 GMT)
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  This should work. If you have highmem pages and your device can't
>  handle >32-bit physical addresses, then kmap() them
>  before pci_map_sg()ing them and kunmap() them after
>  pci_unmap_sg()ing.

--verbose please, I don't see how kmap() will fix the 32-bit limit issue.

As far I know kmap() doesn't move the page in physical memory, but
creates a virtual mapping for it.  Thus the kernel (i.e. the CPU) can
access it, but PCI busmasters still can't ...

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
