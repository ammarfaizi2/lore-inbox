Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276132AbRI1Pa6>; Fri, 28 Sep 2001 11:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276131AbRI1Pas>; Fri, 28 Sep 2001 11:30:48 -0400
Received: from ns.caldera.de ([212.34.180.1]:27050 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S276129AbRI1Pa1>;
	Fri, 28 Sep 2001 11:30:27 -0400
Date: Fri, 28 Sep 2001 17:30:37 +0200
Message-Id: <200109281530.f8SFUbN18754@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: n.roos@berlin.de (Norbert Roos)
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: inverse mmap() available?
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3BB49438.1F2C59B3@berlin.de>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BB49438.1F2C59B3@berlin.de> you wrote:

> Hello!
>
> Is there a way to map user space memory into kernel address space, e.g.
> that i don't have to call get_user(var,...) but simply use var =
> *user_space_ptr?
>
> What i intend to do (as the next step) is to DMA-transfer data directly
> between a PCI device and user space memory. The buffer in user space
> should be allocated with malloc(), so allocating a buffer in kernel and
> mmap()-ping it to user space is not the solution..
>
> I guess this has been asked before, any links to further information
> would be great.

map_user_kiobuf is what you want :) Some more explanation at:

 ftp://ftp.openlinux.org/pub/people/hch/kio/kiobuf.txt

