Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274497AbRIYFSg>; Tue, 25 Sep 2001 01:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274498AbRIYFSS>; Tue, 25 Sep 2001 01:18:18 -0400
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:4807 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S274497AbRIYFSK>; Tue, 25 Sep 2001 01:18:10 -0400
Message-ID: <3BB013D3.6060408@wipro.com>
Date: Tue, 25 Sep 2001 10:49:15 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] OOM aware applications
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I was looking at the code in oom_kill.c, I had the following suggestions

Warning: I am not aware of what was discussed earlier about these issues 
or if they were discusses at all.

1. I was wondering that instead of killing the application using 
oom_kill_task() directly, should the OOM
    issue some kind of a warning by sending a signal (some signal with 
si_code set to a value indicating that
    the application is causing memory to run out). Then, wait for a 
while and then see if the application is still
    misbehaving and if so kill it.

2. Minor changes suggested

    In the code, I see

    points *= 2 and points /= 4 in a few places, recommend changing them to

    points <<= 1 and points >>= 2 to help the compiler generate better code


Dialog between the kernel and an OOM aware application

on OOM condition

kernel to the application: Hey u  are running the system out of memory
application: Sorry my lord, I commited a blunder and will rectify myself

application rectifies itself and everybody lives happily everafter
application is stuborn

kernel: You must go now, u have been unfair in your demands and have 
caused a lot of problem
application: Does not get to say anything, it is zapped

Comments, Suggestions, Criticism
Balbir




--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
