Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318734AbSG0LR4>; Sat, 27 Jul 2002 07:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318735AbSG0LR4>; Sat, 27 Jul 2002 07:17:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:11517 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318734AbSG0LRz>; Sat, 27 Jul 2002 07:17:55 -0400
Subject: Re: i810_audio.c cli/sti fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Doug Ledford <dledford@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0207271103180.2606-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0207271103180.2606-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 Jul 2002 13:35:42 +0100
Message-Id: <1027773342.17404.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-27 at 10:10, Ingo Molnar wrote:
> how about a disable_irq_all() and enable_irq_all() call, which would
> disable every single interrupt source in the system? Sure it's a bit
> heavyweight (it disables the timer interrupt too), but if some driver
> **really** needs complete silence in the IRQ system then it might be
> useful. It would roughly be equivalent to cli() and sti(), from the
> hardirq disabling point of view. [it would not disable bottom halves.]

For the precision needed I think a local irq disable and the lock the
driver needs itself are sufficient, and the lock _irqsave will handle
the IRQ bits

