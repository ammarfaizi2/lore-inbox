Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSCHXVL>; Fri, 8 Mar 2002 18:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSCHXVC>; Fri, 8 Mar 2002 18:21:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54802 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288748AbSCHXUs>; Fri, 8 Mar 2002 18:20:48 -0500
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
To: frankeh@watson.ibm.com
Date: Fri, 8 Mar 2002 23:36:01 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org
In-Reply-To: <20020308231405.CADDC3FE06@smtp.linux.ibm.com> from "Hubertus Franke" at Mar 08, 2002 06:15:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jTu5-0007xS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's not just 386 vs later due to cmpxchg. It's also the simple issue of
> > UP vs SMP - a UP system still wants to do locking, but it doesn't need the
> > lock prefix. And that lock prefix makes a _huge_ difference
> > performance-wise.
> 
> Fail to see why that matters. User level locking is mostly beneficial on SMPs.
> So, you lock the bus for the atomic update. This is UP, nothing's going on 
> on the bus anyway.

Lots of older x86 is too stupid to optimise exclusive cache line locked
operations. After all the bus is still shared - PCI bus masters for one

Alan
