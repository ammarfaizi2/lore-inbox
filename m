Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263995AbRFHNvF>; Fri, 8 Jun 2001 09:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263997AbRFHNuz>; Fri, 8 Jun 2001 09:50:55 -0400
Received: from f220.law11.hotmail.com ([64.4.17.220]:4870 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S263995AbRFHNuo>;
	Fri, 8 Jun 2001 09:50:44 -0400
X-Originating-IP: [165.21.83.232]
From: "Louis Lam" <lsauchun@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question on Loop and PPDD devices
Date: Fri, 08 Jun 2001 21:50:38 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F220D8GIOlHmt9QmQMm0001b386@hotmail.com>
X-OriginalArrivalTime: 08 Jun 2001 13:50:38.0556 (UTC) FILETIME=[FFFA61C0:01C0F021]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm quite new to kernel development, please advice....

Got some questions about Loop and PPDD Devices.

*For 2.2 kernels, there are loop-specific modifications in ll_rw_block.c, in 
make_request(), where the max_req is divided by two. Comments read: loop 
uses two requests, 1 for loop and the other for real device.

Q1. How is it exactly using two requests?

Q2. Requests are made to the loop device and when will it generate another 
request to the real device?

Q3. Does the loop device have its own request queue? Or is it using the same 
request queue as the actual device it is associated with?

Q4. What is the relationship between loop device driver and the actual disc 
driver? How/When is data actually written/read from the disk?

Q4. Where can I gather more information on the principles behind the how 
loop devices work? Any particular person who might be able to help?

*I'm Using ppdd to encrypt my swap data, it is very similar to the loop 
device. Currently as suggested by the instructions, I'm using a swap file in 
an encrypted partition. I'm trying to port it to the 2.2.14-5.0(Redhat 6.2 
Kernel)and noticed that when I try to run something like "make -j 3" , there 
are errors in decryption. This did not happen on a standard 2.2.13 kernel. 
Sometimes it deadlocks as well(quite intermittent, but usually when I just 
changed the swap space to the encrypted file).

Q6: What should I be looking for in order to port it to that kernel? 
Understand there are changes to buffer.c and various other files related to 
block I/O, and possibly some to memory management as well.

PS.. I'm currently not subscribed to this mailing list, please send replies 
directly to my email address.

Thank You in Advance,

Louis Lam
lsauchun@hotmail.com
sclam@singnet.com.sg






_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

