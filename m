Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbULCKLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbULCKLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 05:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbULCKLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 05:11:06 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:58894 "EHLO
	globaledgesoft.com") by vger.kernel.org with ESMTP id S262141AbULCKLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 05:11:03 -0500
Message-ID: <41B03BB2.90802@globaledgesoft.com>
Date: Fri, 03 Dec 2004 15:40:58 +0530
From: Kiran Kumar Gaitonde <kiran.gaitonde@globaledgesoft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Kernel Thread in Device Driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: kiran.gaitonde@globaledgesoft.com
X-MDRemoteIP: 172.16.6.155
X-Return-Path: kiran.gaitonde@globaledgesoft.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I am working on a device driver with the device interrupts are actaully 
serviced in a kernel thread and not in the interrupt handler registered 
with the kernel. The interrupt handler justs wakes up the kthread when a 
interrupt occurs. This is done as we need to use semaphores while 
performing IO to sync the read and writes.
Now I have come across a situation where the kthread is consuming 70% of 
CPU time as it is in a loop to service the interrupts happening very 
very fast, and it is rearly saying schedule(). The performance of the 
application which uses this device to communicate, is not good as it is 
not getting CPU at the right time.

Can anybody tell me what may be the problem. Also any suggestions to 
overcome this issue?

Thanks in Advance,

Regards,
Kiran Gaitonde.

