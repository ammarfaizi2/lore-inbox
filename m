Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVGVVk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVGVVk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVGVVj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:39:28 -0400
Received: from [81.2.110.250] ([81.2.110.250]:47264 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262192AbVGVVjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:39:21 -0400
Subject: Re: Kernel doesn't free Cached Memory
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vinicius <jdob@ig.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050722_160051_071630.jdob@ig.com.br>
References: <20050722_160051_071630.jdob@ig.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 22 Jul 2005 23:03:51 +0100
Message-Id: <1122069831.9478.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-22 at 13:00 -0300, Vinicius wrote:
>    I also read on the Linux-Kernel that the problem may be related to an 
> exhaustion of your kernels address space, I read that the hugemem-kernel 
> might be the solution to this case since it has 4GB for the kernel memory 
> plus 4GB for user process. 

If its x86-32 then only the hugemem kernel will even see the memory.
There are big problems with 32Gb+ on a 32bit processor because there is
so little memory usable at a time that even the page tables become
problematic. Thankfully all sane machines with that much ram are 64bit.

