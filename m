Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263942AbUFCLry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUFCLry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 07:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbUFCLrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 07:47:53 -0400
Received: from chaos.analogic.com ([204.178.40.224]:53120 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263942AbUFCLru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 07:47:50 -0400
Date: Thu, 3 Jun 2004 07:46:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: reg@dwf.com
cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
       reg@orion.dwf.com, linux@horizon.com, reg@orion.dwf.com
Subject: Re: Intel 875 Motherboard cant use 4GB of Memory. 
In-Reply-To: <200406030232.i532W4eU008705@orion.dwf.com>
Message-ID: <Pine.LNX.4.53.0406030743260.3377@chaos>
References: <200406030232.i532W4eU008705@orion.dwf.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004 reg@dwf.com wrote:

> >
> > Wrong.  Ever since the Pentium Pro, x86 processors have had 36-bit
> > *physical* addressing.  This is why PAE-mode paging was introduced.  A
> > sane BIOS would configure the memory controller to remap some of the
> > memory above 4G physical to allow for memory mapped devices.  It sounds
> > like this board's BIOS isn't doing that, or at least not reporting it in
> > the e820 map.
> >
> Hummm.
>
> Let me restate the fact that I dont understand how PC hardware works, but
> I can understand how the area for PCI devices has to come out of the
> KERNEL address space, but why does it have to be subtracted from the USER
> address space too?
>
>
> --
>                                         Reg.Clemens
>                                         reg@dwf.com


It isn't. However some of the user address-space is used by the kernel
so a user can't address 32 bits of (data) space either. The sum of
the address-spaces that each user can access can far exceed all the
RAM and certainly 32-bits of space. That's why we have swap-files.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


