Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261951AbREUIHD>; Mon, 21 May 2001 04:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261941AbREUIGx>; Mon, 21 May 2001 04:06:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32526 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261937AbREUIGg>; Mon, 21 May 2001 04:06:36 -0400
Subject: Re: alpha iommu fixes
To: davem@redhat.com (David S. Miller)
Date: Mon, 21 May 2001 09:03:30 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrewm@uow.edu.au (Andrew Morton),
        andrea@suse.de (Andrea Arcangeli),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        rth@twiddle.net (Richard Henderson), linux-kernel@vger.kernel.org
In-Reply-To: <15112.51569.744590.398000@pizda.ninka.net> from "David S. Miller" at May 21, 2001 12:53:21 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151kf4-0003TY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox writes:
>  > And how do you propose to implemnt cache coherent pci allocations
>  > on machines which lack the ability to have pages coherent between
>  > I/O and memory space ?
> 
> Pages, being in memory space, are never in I/O space.

Ok my fault. Let me try that again with clearer Linux terminology.

Pages allocated in main memory and mapped for access by PCI devices. On some
HP systems there is now way for such a page to stay coherent. It is quite
possible to sync the view but there is no sane way to allow any
pci_alloc_consistent to succeed

Alan


