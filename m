Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbULEVNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbULEVNO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 16:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbULEVNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 16:13:14 -0500
Received: from ozlabs.org ([203.10.76.45]:43972 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261395AbULEVNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 16:13:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16819.31194.561882.514591@cargo.ozlabs.ibm.com>
Date: Mon, 6 Dec 2004 08:12:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linh Dang <dang.linh@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][PPC32[NEWBIE] enhancement to virt_to_bus/bus_to_virt (try 2)
In-Reply-To: <3b2b32004120306463b016029@mail.gmail.com>
References: <3b2b32004120206497a471367@mail.gmail.com>
	<3b2b320041202082812ee4709@mail.gmail.com>
	<16815.31634.698591.747661@cargo.ozlabs.ibm.com>
	<3b2b32004120306463b016029@mail.gmail.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linh Dang writes:

> I wrote a DMA engine (to used by other drivers) that (would like to) accept
> all kind of buffers as input (vmalloced, dual-access shared RAM mapped
> by BATs, etc). The DMA engine has to decode the virtual address of the
> input buffer to (possibly multiple) physical  address(es). virt_to_phys()
> has the right name for the job except it only works for the kernel virtual
> addresses initially mapped at KERNELBASE

Have you read Documentation/DMA-API.txt?  It explains the official
kernel API for DMA, and drivers should use it in order to be portable
to more than just one architecture.

If you want to create a competing DMA API, you'll have to show us at
least one driver that really needs your new API.

Also, please don't change the existing virt_to_*/*_to_virt functions.
Instead define your own functions (with different names) in the same
source file as your other new code.

Paul.

