Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbUKGHtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbUKGHtX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 02:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbUKGHtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 02:49:22 -0500
Received: from potato.cts.ucla.edu ([149.142.36.49]:5533 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S261553AbUKGHtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 02:49:19 -0500
Date: Sat, 6 Nov 2004 23:49:14 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: deadlock with 2.6.9
In-Reply-To: <200411070058_MC3-1-8E27-AAEF@compuserve.com>
Message-ID: <Pine.LNX.4.61.0411062342400.29373@potato.cts.ucla.edu>
References: <200411070058_MC3-1-8E27-AAEF@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Nov 2004, Chuck Ebbert wrote:

> Chris Stromsoe wrote:
>
>> I had a third lockup, this time not related to burning a dvd.  As 
>> before, the bulk of the processes that were hung were cron
>
> Why so many cron processes?  Is this normal on your system, or does it 
> look like cron keeps spawning processes because it gets no response on 
> the sockets?

I'm guessing so many processes because every time one gets started, it 
ends up getting stuck in schedule_timeout(), until the system stops 
spawning new processes.  There are many of them because the system was 
running for a day or so before it became unresponsive.

>> The box is P3 SMP
>
> Can you try a uniprocessor kernel?

Boot with nosmp or boot a kernel compiled for up?

>> syslog logs to a stripe of two mirrors, built with mdadm.
>
> Get a real RAID controller (3Ware, not some crappy pseudo-RAID junk.) 
> They are much more reliable than software RAID.

I've had more problems with reliable hardware raid controllers than I have 
with software raid.  Your mileage may vary.


-Chris
