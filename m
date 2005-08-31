Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVHaJ7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVHaJ7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 05:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVHaJ7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 05:59:23 -0400
Received: from [210.76.114.20] ([210.76.114.20]:19622 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1750731AbVHaJ7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 05:59:23 -0400
Message-ID: <43157F88.60900@ccoss.com.cn>
Date: Wed, 31 Aug 2005 17:59:36 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Question] How get instruction pointer of user space ???
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone:

    I am implemnting one ioctl() in one character device.

    That need know instruction pointer of user space. I am on i386 
platform.
I can sure I am in process context. and enter kernel by system call way.

    As I known, in default case, each task have one kernel stack, its length
is THREAD_SIZE(2 pages),  and current_thread_info() is at its top. the
struct pt_regs is at bottom of this stack.

    so I write the code like here:

    pt_regs = ((struct pt_regs *)(THREAD_SIZE + current_thread_info()))+1;
    return pt_regs->eip;

    but it do not work! even, I get segment fault and kernel Oops at 
sometime.
   
    Also, I am sure current_thread_info() return right value of current 
user task.

    Any idea on here?

    thanks


                                                                   sailor.






   




