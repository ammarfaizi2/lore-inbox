Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315852AbSEQMmM>; Fri, 17 May 2002 08:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315884AbSEQMmL>; Fri, 17 May 2002 08:42:11 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63242 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315852AbSEQMmK>; Fri, 17 May 2002 08:42:10 -0400
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 17 May 2002 14:01:30 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        paul@engsoc.org (Paul Faure), linux-kernel@vger.kernel.org
In-Reply-To: <20020517123902.GA11512@dualathlon.random> from "Andrea Arcangeli" at May 17, 2002 02:39:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178hMQ-0006Sb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, May 17, 2002 at 01:49:21PM +0100, Alan Cox wrote:
> > I think its mostly #2. We invoke ksoftirq far far too easily.
> 
> ksoftirqd + SCHED_FIFO is like no ksoftirqd at all, provided the ne card
> is irq driven (it is) everything works like it was working in 2.4.0.

For a 10Mbit ne2k it ought to be if its done with sched fifo. For serious
devices its not. The ksoftirqd bounce blows everything out of cache and is
easily measured

