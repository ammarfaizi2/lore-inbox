Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313293AbSEVNZ5>; Wed, 22 May 2002 09:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313300AbSEVNZ5>; Wed, 22 May 2002 09:25:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35856 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313293AbSEVNZz>; Wed, 22 May 2002 09:25:55 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: rmk@arm.linux.org.uk (Russell King)
Date: Wed, 22 May 2002 14:23:10 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        davem@redhat.com (David S. Miller), paulus@samba.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020522133613.D16934@flint.arm.linux.org.uk> from "Russell King" at May 22, 2002 01:36:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AW58-0001eU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kmem = kernel memory.  That may not be the same as the physical
> memory (the fact that it is at present I find mostly irrelevant here).
> /dev/mem is the more correct device to use for this purpose.

/dev/mem is also not strictly correct. Linux in/out space is operated as
synchronous I/O operations. A dumb map of /dev/mem areas can lead to
differences if the platform concerned has to do the I/O post and wait
completion handling in software. (O_SYNC is also not enough since thats
memory caching not PCI posting)

Alan
