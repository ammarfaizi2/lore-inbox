Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266565AbUHIN0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266565AbUHIN0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUHIN0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:26:51 -0400
Received: from bay12-f12.bay12.hotmail.com ([64.4.35.12]:48910 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266565AbUHIN0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:26:47 -0400
X-Originating-IP: [136.182.2.222]
X-Originating-Email: [rameshred@hotmail.com]
From: "Ramesh Sudini" <rameshred@hotmail.com>
To: kernoulas@sisifus.ceid.upatras.gr
Cc: linux-kernel@vger.kernel.org
Subject: Re: Copy_to_user and copy_from_user
Date: Mon, 09 Aug 2004 13:26:45 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY12-F12qunLOyDc4100039e06@hotmail.com>
X-OriginalArrivalTime: 09 Aug 2004 13:26:46.0104 (UTC) FILETIME=[84860D80:01C47E14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Then, how do I make sure that all the data I wanted to be copied is infact 
copied?? What are the scenarios where copy_to/from_user could fail and how 
can I avoid it.

Thanks
-Ramesh


>
>No you cannot call it until all data has been copied. copy_{to,from}_user 
>fails when a fault happens during the copy process. So you simply cannot 
>try again... It will fault again.
>Well, not 100% true. An other running thread (same mm with the process 
>which copies data) can "fix" the faulty adress space. Bad thread....
>
>Ramesh Sudini wrote:
>>Hi,
>>
>>If copy_from_user returns non zero value, then I do not see any driver(for 
>>example PPP) try to copy the remaining data. It treats it as an error 
>>scenario.
>>
>>Why is this? Shouldnt it have a while loop and attempt to copy_from_user 
>>till all the data is copied??
>>
>>I am writing a driver and trying to understand what needs to be done in 
>>case it returns a non-zero value? I have huge amount of data to be copied 
>>from user space Ex: 3000byte messages.
>>
>>Can somebody suggest me what is the best I could do...(Please cc me 
>>personally with your response)
>>
>>Thanks
>>Ramesh
>>

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

