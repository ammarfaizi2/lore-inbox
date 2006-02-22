Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWBVVpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWBVVpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWBVVpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:45:51 -0500
Received: from terminus.zytor.com ([192.83.249.54]:46542 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751474AbWBVVpu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:45:50 -0500
Message-ID: <43FCDB8A.5060100@zytor.com>
Date: Wed, 22 Feb 2006 13:45:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: klibc@zytor.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: sys_mmap2 on different architectures
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've looked through the code for sys_mmap2 on several architectures, and 
it looks like some architectures plays by the "shift is always 12" rule, 
  e.g. SPARC, and some expect userspace to actually obtain the page 
size, e.g. PowerPC and MIPS.  On some architectures, e.g. x86 and ARM, 
the point is moot since PAGE_SIZE is always 2^12.

a. Is this correct, or have I misunderstood the code?

b. If so, is this right, or is this a bug?  Right now both klibc and 
µClibc consider the latter a bug.

c. Which architectures are affected which way?

	-hpa
