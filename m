Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270491AbUJTUIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270491AbUJTUIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269214AbUJTUIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:08:15 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:15835 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270491AbUJTUCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:02:32 -0400
Subject: Re: Running user processes in kernel mode; Java and .NET
	support	in kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4173BC21.24859.11899F91@localhost>
References: <82fa66380410152111143f75ec@mail.gmail.com>
	 <4173BC21.24859.11899F91@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098298776.12366.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 20 Oct 2004 19:59:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-10-18 at 20:50, Kendall Bennett wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Why would I care ? I need the MMU for paging and to avoid
> > fragmentation of the system. If I have the MMU on then memory
> > protection checks are free. 
> > 
> > Except in 4G/4G mode syscalls are extremely cheap too nowdays.
> 
> Yes, but kernel mode support in user programs would allow user mode 
> device drivers to do stuff that currently cannot be done at all from user 
> space such as handling interrupts and scheduling DMA operations.

DMA doesn't need the kernel's help except for when you want to manage
security - DRI is quite special in that way. A driver to provide
mmapable DMA memory is trivial. IRQ's are *much* harder because you have
to clear the IRQ source in the IRQ handler, but people have code that
does this and then sends signals.

