Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285363AbRLGBax>; Thu, 6 Dec 2001 20:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285364AbRLGBan>; Thu, 6 Dec 2001 20:30:43 -0500
Received: from daytona.gci.com ([205.140.80.57]:57357 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S285363AbRLGBaa>;
	Thu, 6 Dec 2001 20:30:30 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA31506DB3FA5@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Tim Hockin <thockin@sun.com>, Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] eepro100 - need testers
Date: Thu, 6 Dec 2001 16:30:12 -0900 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin responded to
> Jeff Garzik who wrote:
>  
>> This patch got me thinking about net driver ring sizes in 
>> general.  When you are talking thousands of packets per second
>> at 100 mbit, a larger ring size than the average 32-64 seems
>> to make sense too.
> 
> Well, the math for the very worst case is something like: 
> 
> 100,000,000  bits/sec
> /8  = 12500000  bytes/sec
> /64 bytes/ping = 195312.5  ping/sec
> /100 = 1953 ping/jiffy
> rounded to 2048 /2 = 1024 rx buffers per 1/2 jiffie.  
> 
> 1024 means you can withstand a wire-speed storm while 
> interrupting twice per jiffy.

Given this, and the ever-upward climb in ethernet speed,
what would be the dangers involved in making this a run-time
option?

As soon as we detect the device, we know what it's max speed is,
and we can then build the ring size base on that knowledge.

just some ignorant thoughts..

