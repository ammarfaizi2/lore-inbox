Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbVKRIhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbVKRIhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 03:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbVKRIhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 03:37:15 -0500
Received: from [210.76.114.20] ([210.76.114.20]:2478 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1030514AbVKRIhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 03:37:14 -0500
Message-ID: <437D92C5.1060902@ccoss.com.cn>
Date: Fri, 18 Nov 2005 16:37:25 +0800
From: liyu <liyu@ccoss.com.cn>
Reply-To: liyu@ccoss.com.cn
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [Question] spin_lock in interrupt handler.
References: <4379B5EB.40709@ccoss.com.cn> <437A8867.8080809@ccoss.com.cn> <437C2133.2030103@ccoss.com.cn> <200511172057.33131.kernel@kolivas.org>
In-Reply-To: <200511172057.33131.kernel@kolivas.org>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, every one in LKML.

    I have one question about how to use spin_lock.

    I read Documentation/spinlocks.txt wrote by Linus. The Lesson 1 and 
2 are simple for me.
But I confused in Lesson 3. The most doublt is why we can not use 
spin_lock_irq*() version in
interrupt handler?

    At i386, I known the interrupt is disabled in interrupt handler. I 
think this feature is
supplied in handware-level. The spin_lock_irqrestore() will use  'sti'  
instruction internal, it will change interrupt mask bit in FLAGS 
register, do this have re-enable interrupt, even in interrput handler? I 
can not sure this.

    Thanks in advanced.

-liyu
   


