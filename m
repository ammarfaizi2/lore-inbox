Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270928AbTGPPx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270929AbTGPPx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:53:29 -0400
Received: from 115.114.254.64.virtela.com ([64.254.114.115]:5138 "EHLO
	megisto-sql1.megisto.com") by vger.kernel.org with ESMTP
	id S270928AbTGPPx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:53:28 -0400
Message-ID: <C3F7A1AD0781F84784B5528466CA09DD01345643@megisto-sql1>
From: Pankaj Garg <PGarg@MEGISTO.com>
To: linux-kernel@vger.kernel.org
Subject: ioremap'ing RAM
Date: Wed, 16 Jul 2003 11:59:07 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the first time I am posting to this group. If this question does not
belong to this mailing list please ignore it. I would really appreciate if
any one could point me to the correct list.

I am trying to allocate a huge chunk of memory for my module. The memory is
needed to be contiguous in physical address space and is much more than what
kmalloc returns. I reserved some high memory at the bootup time of the
kernel (using the command line option mem), and at the time of module
initialization used ioremap to grab that chunk of memory. All this is
working fine.

My module creates a table in this allocated address space. The table is not
going out of bound.

The module sniff's the packet coming in through the network card and does a
find on the table.

The problem is, if I load the module just after startup (within a second or
two), the kernel crashes. If I do it a little later, say 2-3 mins later, it
crashes after 1-2 days. 

Is there anything wrong in the way I am doing memory allocation?

Regards,
Pankaj

