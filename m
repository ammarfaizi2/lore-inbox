Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316766AbSFUTKP>; Fri, 21 Jun 2002 15:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSFUTKO>; Fri, 21 Jun 2002 15:10:14 -0400
Received: from iere.net.avaya.com ([198.152.12.101]:40882 "EHLO
	iere.net.avaya.com") by vger.kernel.org with ESMTP
	id <S316766AbSFUTKO>; Fri, 21 Jun 2002 15:10:14 -0400
Message-ID: <3D137A16.2080303@avaya.com>
Date: Fri, 21 Jun 2002 13:10:14 -0600
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
Organization: Avaya, Inc.
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.2.21
References: <E17LSDo-0001KB-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jun 2002 19:10:15.0675 (UTC) FILETIME=[469404B0:01C21957]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>The 2.2.21 kernel was behaving incorrectly for SCHED_FIFO and SCHED_RR 
>>scheduling.
> 
> 
> Looks fine but I dont want to apply behaviour changing non critical stuff
> to 2.2

Oh, no!

What's going on with the kernel community? I posted a similar fix for 
the 2.4.18 kernel, and it hasn't been picked up there either.

For the 2.4.18 kernel scheduler, our 86 process application (SCHED_FIFO, 
priorities 7-23, System V semaphores for priority preemption) won't even 
stay up without my patch.

The 2.2.21 SCHED_FIFO behaviour is correct but slightly inefficient, 
while the SCHED_RR behaviour is plain broken. What is an application 
that depends on correct SCHED_RR behaviour to do in that case? There are 
applications where increased latencies as a result of SCHED_RR being 
broken are unacceptable.

-- 
Bhavesh P. Davda
Avaya Inc
Room B3-B03                     E-mail : bhavesh@avaya.com
1300 West 120th Avenue          Phone  : (303) 538-4438
Westminster, CO 80234           Fax    : (303) 538-3155

