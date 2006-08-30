Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWH3BqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWH3BqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 21:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWH3BqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 21:46:06 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6329 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751505AbWH3BqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 21:46:04 -0400
Date: Tue, 29 Aug 2006 19:45:15 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Multithreading and signals on linux
In-reply-to: <1156901077.044202.142840@h48g2000cwc.googlegroups.com>
To: Shrikrishna Khare <shri.khare@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <44F4EDAB.3000903@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1156901077.044202.142840@h48g2000cwc.googlegroups.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shrikrishna Khare wrote:
> Hi,
> 
>     Am using pthread_kill to send SIGUSR1 from thread t1 to thread t2.
> However, I am unable to have "different" signal handlers for threads t1
> and t2 for same signal SIGUSR1.
>     I have ensured that I set the signal handler for t1 and t2
> separately in different functions. Could anyone please tell me if I am
> missing on something?

The signal will be handled in the thread specified, however signal 
handlers are global to the process. You cannot have different signal 
handlers for different threads in the same process. This is the way 
POSIX pthreads are specified to work.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

