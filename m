Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbSLLX7A>; Thu, 12 Dec 2002 18:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbSLLX7A>; Thu, 12 Dec 2002 18:59:00 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:24316 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S264939AbSLLX67>; Thu, 12 Dec 2002 18:58:59 -0500
Message-ID: <3DF9244C.7080705@drugphish.ch>
Date: Fri, 13 Dec 2002 01:05:32 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (8/8): export sys_wait4.
References: <20021212142645.A2998@devserv.devel.redhat.com> <3DF8FD59.9030100@drugphish.ch> <20021212181747.B28477@devserv.devel.redhat.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>+EXPORT_SYMBOL(sys_wait4);
>>>
>>>Martin, hold on just a second. Last I checked, sys_wait4 was
>>>used ONLY by a moronic code in ipvs, _and_ there was a comment
>>>by the author above it "we are too lazy to do it properly".
>>>Do you have a better reason to export it?
>>
>>Guess I'm the malefactor this time since I've sent this patch to Martin 
>>after some email exchanges with a guy that wanted LVS to work on a s390. 
>>I reckon I will fix the said moronic code to use a syscall wrapper for 
>>sys_wait4() so we don't step on anyone's toes.
>  
> I should not have called it moronic. Everyone has schedule

Don't worry about it. We haven't always been too kind with lost RH 
piranha users in the past either ;).

> constraints. I am wondering though, if the LVS and ipvs
> module are maintained actively. Perhaps I owe them a patch.

LVS and its kernel modules are definitely actively maintained all the 
way from 2.2.x to 2.5.x kernels and if you want I'll make you a 2.0.x 
kernel version too. It's just that recently everybody got a bit busy and 
thus new releases tend to follow each other in increasing time intervals.

A patch would always be very welcome of course.

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

