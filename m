Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbUKHHNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbUKHHNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 02:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbUKHHNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 02:13:51 -0500
Received: from [210.17.210.210] ([210.17.210.210]:23194 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S261762AbUKHHNk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 02:13:40 -0500
Message-ID: <418F1DEB.7000905@avantwave.com>
Date: Mon, 08 Nov 2004 15:19:07 +0800
From: mike <mikelee@avantwave.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel mailing <linux-kernel@vger.kernel.org>
Subject: About Tasklet scheduling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

    I am new to kernel driver development. Thanks for any help.

    I am modifing a USB Ramdisk to a USB mass storage(MTD) driver in a 
dragonball ARM9 platform.  I stop when using tasklet. The USB driver 
setup with endpoint 1 and 2 to be Interrupt IN and OUT point. So when 
ever there is a interrupt , I schedule the tasklet to read or write with 
semphone variable protection.
    The problem i am facing is that the read/write process is TOO SLOW 
for the host to response. I have tried to not use tasklet and call the 
read/write function directly, it works with small file but "schedule in 
interrupt" oops prompt out when transfer a large file . I have also try 
to use spin_lock_irqsave.. but it will stop the interrupt...

    I am in a hurry on this. Please give me a hand.

    Thanks

Mike,Lee
