Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbTAINl6>; Thu, 9 Jan 2003 08:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbTAINl6>; Thu, 9 Jan 2003 08:41:58 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:23492 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S266682AbTAINl5>; Thu, 9 Jan 2003 08:41:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Schlichter <schlicht@uni-mannheim.de>
Subject: NEED HELP about flush_map() in pageattr.c
Date: Thu, 9 Jan 2003 14:50:37 +0100
User-Agent: KMail/1.4.3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301091450.37918.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

currently I am writing a patch to be able to make TLBs on any IO-devices
coherent to the CPUs TLBs. So I was looking in the kernel-sources for places
where not only the local but all TLBs are flushed. So I came up with
flush_map() in the arch/i386/mm/ and the arch/x86_64/mm/ directories.

Now my questions:

1. In the x86_64 part of code the flush_kernel_map() does a
local_flush_tlb_one() but in the i386 parts a local_flush_tlb_all(). Is the
mentioned athlon bug the cause or can it be changed to work as in the x86_64
code?

2. Can the flush_map() function be replaced by a flush_tlb_all() respective
flush_tlb_page(). If I can do so, what would be the correct value for the
first argument 'vma'?

If it is not posible could you please tell me why not...?

Thank you very much!

  Thomas Schlichter

