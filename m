Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132422AbRAZPnL>; Fri, 26 Jan 2001 10:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132147AbRAZPnB>; Fri, 26 Jan 2001 10:43:01 -0500
Received: from colorfullife.com ([216.156.138.34]:57096 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132546AbRAZPmo>;
	Fri, 26 Jan 2001 10:42:44 -0500
Message-ID: <3A719AFE.922A8005@colorfullife.com>
Date: Fri, 26 Jan 2001 16:42:54 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: rjohnson@analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + * 
> + * Changed the slow-down I/O port from 0x80 to 0x19. 0x19 is a 
> + * DMA controller scratch register. rjohnson@analogic.com 
>    */ 
>  
What about making that a config option?

default: delay with 'outb 0x80', other options could be
	udelay(n); (n=1,2,3)
	outb 0x19

0x80 is a safe port, and IMHO changing the port on all i386 systems
because it's needed for some embedded system debuggers is too dangerous.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
