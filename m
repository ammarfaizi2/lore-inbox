Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWHCUxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWHCUxe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWHCUxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:53:34 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50897 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751370AbWHCUxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:53:33 -0400
Subject: Re: A proposal - binary
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy Tarreau <w@1wt.eu>
Cc: Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
In-Reply-To: <20060803202929.GA8776@1wt.eu>
References: <44D1CC7D.4010600@vmware.com>
	 <1154611272.23655.71.camel@localhost.localdomain>
	 <20060803202929.GA8776@1wt.eu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 22:12:46 +0100
Message-Id: <1154639566.23655.132.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-03 am 22:29 +0200, ysgrifennodd Willy Tarreau:
> I think that the issue Zach tried to cover is the current inability to
> keep the same binary module across multiple kernel versions. That's why
> he compared modules<->kernel to ELF<->glibc. In that sense, he's right.

I think thats why he's wrong.

The interface for a hypedvisor is

      Kernel -> Something -> Hypedvisor

The kernel->something interface can change randomly by day of week, who
cares. A better analogy would be a device driver - we recompile device
drivers each kernel variant, which change their internal interfaces, we 
redesign their locking but we don't have to change the hardware.

Ditto talking to the hypedvisor. The ABI is the hypedvisor syscall/trap
interface not the kernel module interface. As such insmod is just fine.

Alan

