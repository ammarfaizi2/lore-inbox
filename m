Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265388AbRGBSVA>; Mon, 2 Jul 2001 14:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbRGBSUv>; Mon, 2 Jul 2001 14:20:51 -0400
Received: from [64.64.109.142] ([64.64.109.142]:53516 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S265382AbRGBSUm>; Mon, 2 Jul 2001 14:20:42 -0400
Message-ID: <3B40BB72.64EE38C6@didntduck.org>
Date: Mon, 02 Jul 2001 14:20:34 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Swami <swamis@iastate.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Doubt in interrupts
In-Reply-To: <Pine.OSF.3.95.1010702123304.30601F-100000@isua1.iastate.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Swami wrote:
> 
> Hi,
> 
> Are there any interrupts which doesn't affect local_irq_count(cpu) or that
> doesn't enter do_IRQ()? (other than NMIs).
> 
> Because I'm implementing my own locking routine and I'm getting
> interrupted during spin, but I check and found that in_interupt() returns
> zero.

All hardware interrupts go through do_IRQ.  There are also CPU
exceptions and inter-processor interupts (SMP only) that have individual
handlers.

--

				Brian Gerst
