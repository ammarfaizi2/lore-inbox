Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbULBUdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbULBUdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbULBUdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:33:37 -0500
Received: from ozlabs.org ([203.10.76.45]:13023 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261757AbULBUb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:31:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16815.31634.698591.747661@cargo.ozlabs.ibm.com>
Date: Fri, 3 Dec 2004 07:31:14 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linh Dang <dang.linh@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][PPC32[NEWBIE] enhancement to virt_to_bus/bus_to_virt (try 2)
In-Reply-To: <3b2b320041202082812ee4709@mail.gmail.com>
References: <3b2b32004120206497a471367@mail.gmail.com>
	<3b2b320041202082812ee4709@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linh Dang writes:

> In 2.6.9 on non-APUS ppc32 platforms, virt_to_bus() will just subtract
> KERNELBASE  from the the virtual address. bus_to_virt() will perform
> the reverse operation.
> 
> This patch will make virt_to_bus():
> 
>      - perform the current operation if the virtual address is between
>        KERNELBASE and ioremap_bot.

Why do you want to do this?  The only code that should be using
virt_to_bus or bus_to_virt is the DMA API code, and it's happy with
them the way they are.

> The patch also changes virt_to_phys()/phys_to_virt() in a similar way.

What do you want to use them for?  They are only for use in low-level
memory management code.

Paul.
