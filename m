Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbRHaTBY>; Fri, 31 Aug 2001 15:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbRHaTBO>; Fri, 31 Aug 2001 15:01:14 -0400
Received: from chopin.beltron.com ([207.236.241.244]:46855 "EHLO
	chopin.beltron.com") by vger.kernel.org with ESMTP
	id <S268940AbRHaTBB>; Fri, 31 Aug 2001 15:01:01 -0400
Message-ID: <F50B5436A4CED31190DA000629386F010168A9C7@CHOPIN>
From: =?iso-8859-1?Q?=22Hammond=2C_Jean-Fran=E7ois=22?= 
	<Jean-Francois.Hammond@mindready.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Scheduling in interrup
Date: Fri, 31 Aug 2001 14:54:53 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the bug :

Scheduling in interrupt
kernel BUG at sched.c:706!
< all the registers are dump >
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

General information :

Kernel version : 2.4.8 without SMP
GCC version : 2.96-81 (Red Hat 7.1)

I am developing in the kernel. I got two PC with one network card for each.
The bug appear when trying to stress my network driver by sending a lot
of packet to one node on the network. The PC that is sending packets
seems to work fine, but the one that receiving packets get the bug after 
a while. My interrupt handler does not have bottom half and my interrupt
as the options : SA_INTERRUPT and SA_SHIRQ.

I got two possible answer. The first possible answer to this is my interrupt
routine stays too long at the interrupt level. The second answer is I lock
the
interrupt for a long time.

Do you have any suggestion to this problem ?

Thanks,

Jean-Francois Hammond
