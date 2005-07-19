Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVGSLfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVGSLfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 07:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVGSLfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 07:35:19 -0400
Received: from [210.76.114.20] ([210.76.114.20]:24212 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S261969AbVGSLfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 07:35:17 -0400
Message-ID: <42DCE551.80104@ccoss.com.cn>
Date: Tue, 19 Jul 2005 19:34:41 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: How linear address translate to physical address in kernel space?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI, every in LKML.

    I have a question that can not understand.

    In kernel space, how linear address translate to physical address ? 
In many kernel bookes,
they said "directly mappd", I think I seen what they said, their mean is 
use __pa()/__va() macro
pair.

    (My platform is i386.)

    but these macro use in case that require use physical address 
explicitly, but in most case,
kernel more need translate them hiddenly. In user space, this 
translation is handled by MMU and
pagefault exception handler of kernel.

    I think kernel can not use CR3 register directly for this purpose, 
beacause of , for example,
when kernel need to switch between user space task, it need change CR3 
regsiter to switch task
address space, if kernel also use CR3 register, this CR3 change will 
break down kernel control flow.

   
    I don't known if I say my question clearly, my english so poor. but 
I am waitting to any answer.

    Thanks in advanced.



                                                                         
   liyu/NOW~


   


   

