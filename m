Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135216AbRDLQIo>; Thu, 12 Apr 2001 12:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135217AbRDLQIe>; Thu, 12 Apr 2001 12:08:34 -0400
Received: from [212.199.50.10] ([212.199.50.10]:26563 "EHLO
	specialk.benyossef.com") by vger.kernel.org with ESMTP
	id <S135216AbRDLQIR>; Thu, 12 Apr 2001 12:08:17 -0400
Message-ID: <3AD5C626.2050507@benyossef.com>
Date: Thu, 12 Apr 2001 18:13:42 +0300
From: Gilad Ben-Yossef <gilad@benyossef.com>
Organization: Great Illuminated Seers of Bavaria
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cpu load calculation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

We think we might have encountered a problem with the cpu load 
calculation in Linux (2.2.x). The current calculation is based on 
dividing the jiffies to user, system and idle jiffies according to the 
process the timer hardware interrupt interrupts.

In our case the timer interrupt generates some kernel processing in the 
bottom half. After that finishes, the idle process takes over.

The system therefore seems completely idle while in actuality if the 
kernel processing takes 50% of a jiffie the system is 50% loaded (with 
system processing).

The problem obviously results from synchronization of processing with 
the timer interrupt used to calculate the load.

- Did anybody encounter this problem?
- Know any solutions?
- Recommend any specific solution?

Many thanks,
Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com :: +972(54)756701
"Anything that can go wrong, will go wrong, while interrupts are disabled. "
	-- Murphey's law of kernel programing.

