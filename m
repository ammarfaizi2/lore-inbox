Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261655AbSJAOkc>; Tue, 1 Oct 2002 10:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261656AbSJAOkc>; Tue, 1 Oct 2002 10:40:32 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:58461 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261655AbSJAOka>; Tue, 1 Oct 2002 10:40:30 -0400
Date: Tue, 1 Oct 2002 10:45:52 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Eitan Ben-Nun <eitan@sangate.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       Uri Lublin <uri@sangate.com>, Marcus Barrow <mbarrow@sangate.com>
Subject: Re: Adpter card read old memory value
Message-ID: <20021001104552.A5475@devserv.devel.redhat.com>
References: <B71796881E0DF7409F066FE6656BDF2906F78B@beasley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B71796881E0DF7409F066FE6656BDF2906F78B@beasley>; from eitan@sangate.com on Tue, Oct 01, 2002 at 05:44:07PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Oct 01, 2002 at 05:44:07PM +0300, Eitan Ben-Nun wrote:
> ok thanks,
> An adapter card on the pci bus send a message to pc i386 Linux to update a memory address. 
> Then it reads the address and sees an old value, even though the pc cpu have performed an update to this memory address. Here is referance to my driver code:
> int update_cluster_operation_mode(unsigned long new_mode, 
> 					    unsigned long phys_addr);
> {
>    unsigned long* vir_addr = 0;
>    vir_addr = __ioremap(phys_addr, PAGE_SIZE, _PAGE_PWT | _PAGE_PCD);
>    *vir_addr = new_mode;
>    return 0;
> }
> phys_addr - is always on page bonderies and the address is between 512M-640M.

this is only a part of the source, is there a full source available?

also your code is already buggy; you should use writel(); and also read up
on PCI posting....

Greetings,
   Arjan van de Ven
