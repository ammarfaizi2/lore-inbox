Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbSLIWDV>; Mon, 9 Dec 2002 17:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbSLIWDV>; Mon, 9 Dec 2002 17:03:21 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:33738 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266186AbSLIWDT>;
	Mon, 9 Dec 2002 17:03:19 -0500
Message-ID: <3DF5147D.9060708@us.ibm.com>
Date: Mon, 09 Dec 2002 14:09:01 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: benh@kernel.crashing.org
CC: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] (0/4) stack updates for x86
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel currently uses an 8k stack, per task.  Here is the 
infrastructure needed to allow us to halve that.  The original work 
was by Ben LaHaise.  I broke it out into several patches and updated 
it for the current kernels.

A-thread_info_cleanup-2.5.50+bk-5.patch
	Gets asm-i386/thread_info.h ready for the irqstack and
	overflow detection patches

B-interrupt_stacks-2.5.50+bk-5.patch
	Have special stacks for use in interrupts.

C-stack_usage_check-2.5.50+bk-5.patch
	Check for stack overflows on entry to each funtion.  Use gcc's
	-p profiling feature to do it.

D-4k-stack-2.5.50+bk-5.patch
	make a config option to turn on 4k stacks.  (there appears to
	be a problem with this right now).

-- 
Dave Hansen
haveblue@us.ibm.com

