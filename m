Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRDJMLS>; Tue, 10 Apr 2001 08:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131586AbRDJMLJ>; Tue, 10 Apr 2001 08:11:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10501 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131563AbRDJMLE>; Tue, 10 Apr 2001 08:11:04 -0400
Subject: Re: No 100 HZ timer !
To: ak@suse.de (Andi Kleen)
Date: Tue, 10 Apr 2001 13:12:14 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        mbs@mc.com (Mark Salisbury), jdike@karaya.com (Jeff Dike),
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010410140202.A15114@gruyere.muc.suse.de> from "Andi Kleen" at Apr 10, 2001 02:02:02 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mx0K-00049P-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does not sound very attractive all at all on non virtual machines (I see the point on
> UML/VM):
> making system entry/context switch/interrupts slower, making add_timer slower, just to 
> process a few less timer interrupts. That's like robbing the fast paths for a slow path.

Measure the number of clocks executing a timer interrupt. rdtsc is fast. Now
consider the fact that out of this you get KHz or better scheduling 
resolution required for games and midi. I'd say it looks good. I agree
the accounting of user/system time needs care to avoid slowing down syscall
paths

Alan


