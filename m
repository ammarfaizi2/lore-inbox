Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWDFNKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWDFNKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 09:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDFNKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 09:10:20 -0400
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:53682 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751247AbWDFNKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 09:10:19 -0400
Date: Thu, 6 Apr 2006 15:10:03 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: "saeed bishara" <saeed.bishara@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: add new code section for kernel code
Message-ID: <20060406151003.0ef4e637@localhost>
In-Reply-To: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com>
References: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2006 15:45:47 +0300
"saeed bishara" <saeed.bishara@gmail.com> wrote:

>  I'm developing linux kernel for ARM cpu with direct-mapped
> instruction cache, sometimes I notice that the pefromance of the
> kernel (for some test) is highly dependent on the code layout, in
> order to fix that I added new code section, and for each kernel
> function that highly invokerd I added compiler attribute so it will
> allocated in that section (exactly as the __init section)

It's already done in 2.6.17-rc1 for x86_64:

Processor type and feature --> Function reordering

arch/x86_64/Kconfig:

config REORDER
        bool "Function reordering"
        default n
        help
         This option enables the toolchain to reorder functions for a more
         optimal TLB usage. If you have pretty much any version of binutils,
         this can increase your kernel build time by roughly one minute.

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4bdc3b7f1b730c07f5a6ccca77ee68e044036ffc

-- 
	Paolo Ornati
	Linux 2.6.16.1 on x86_64
