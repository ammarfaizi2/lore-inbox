Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279878AbRKIMwh>; Fri, 9 Nov 2001 07:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279901AbRKIMw2>; Fri, 9 Nov 2001 07:52:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19208 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279878AbRKIMwJ>; Fri, 9 Nov 2001 07:52:09 -0500
Subject: Re: speed difference between using hard-linked and modular drives?
To: davem@redhat.com (David S. Miller)
Date: Fri, 9 Nov 2001 12:59:09 +0000 (GMT)
Cc: ak@suse.de, anton@samba.org, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20011108.231632.18311891.davem@redhat.com> from "David S. Miller" at Nov 08, 2001 11:16:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E162BFV-0002y1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh no, not this again...
> 
> It _IS_ a big deal.  Fetching _ONE_ hash chain cache line
> is always going to be cheaper than fetching _FIVE_ to _TEN_
> page struct cache lines while walking the list.

Big picture time. What costs more - the odd five cache line hit or swapping
200Kbytes/second on and off disk ? - thats obviously workload dependant.

Perhaps at some point we need to accept there is a memory/speed tradeoff
throughout the kernel and we need a CONFIG option for it - especially for
the handheld world. I don't want to do lots of I/O on an ipaq, I don't need
big tcp hashes, and I'd rather take a small performance hit.

