Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVBCJpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVBCJpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 04:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVBCJpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 04:45:17 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:11138 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262582AbVBCJpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 04:45:07 -0500
Date: Thu, 03 Feb 2005 18:37:47 +0900 (JST)
Message-Id: <20050203.183747.85413533.taka@valinux.co.jp>
To: vgoyal@in.ibm.com
Cc: ebiederm@xmission.com, akpm@osdl.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com, hari@in.ibm.com,
       suparna@in.ibm.com
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based
 crashdumps.
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <1107421303.11609.183.camel@2fwv946.in.ibm.com>
References: <1106833527.15652.146.camel@2fwv946.in.ibm.com>
	<20050203.160252.104031714.taka@valinux.co.jp>
	<1107421303.11609.183.camel@2fwv946.in.ibm.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek, 

> > Hi Vivek and Eric,
> > 
> > IMHO, why don't we swap not only the contents of the top 640K
> > but also kernel working memory for kdump kernel?
> 
> 
> Initial patches of kdump had adopted the same approach but given the
> fact devices are not stopped during transition to new kernel after a
> panic, it carried inherent risk of some DMA going on and corrupting the
> new kernel/data structures. Hence the idea of running the kernel from a
> reserved location came up. This should be DMA safe as long as DMA is not
> misdirected.

I see, that makes sense.
But I'm not sure yet that it's safe to access the top of 640MB.
I wonder how kmalloc(GFP_DMA) works in a kdump kernel.

Thanks,
Hirokazu Takahashi.
