Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132731AbRDDCMh>; Tue, 3 Apr 2001 22:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132730AbRDDCM2>; Tue, 3 Apr 2001 22:12:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:49145 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S132729AbRDDCMV>; Tue, 3 Apr 2001 22:12:21 -0400
Message-ID: <3ACA81C4.55E118DD@mvista.com>
Date: Tue, 03 Apr 2001 19:07:00 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mips@oss.sgi.com
Subject: ack() and end() in hw_irq_controller
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am trying to adopt the new irq.c under arch/i386/kernel to a MIPS board and
hopefully to MIPS common code in general.  This is in the anticipation that
the irq.c file will be moved to common kernel directory in 2.5.

While the rest look pretty self-explanatory, I do have a couple of questions
about ack() and end().

1. It seems to me that in ack() we need to clear any latched, edge triggerred
interrupt AND disable the irq.  True?

2. Similarly end() should re-enable the irq.

3. I don't quite understand the comment about end().  Any explanation?  Does
that imply we should check if it is disable before we re-enable the irq? 
However, it seems such complication can only happen on a SMP, right?

	/*
	 * The ->end() handler has to deal with interrupts which got
	 * disabled while the handler was running.
	 */

Thanks in advance.

Jun
