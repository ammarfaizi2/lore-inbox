Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVDSXbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVDSXbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 19:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDSXbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 19:31:51 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:43873 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261726AbVDSXbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 19:31:45 -0400
Date: Tue, 19 Apr 2005 17:30:57 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: question on 2.4 scheduler, threads, and priority inversion
In-reply-to: <3V45v-tx-39@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <426594B1.9000307@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3V45v-tx-39@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> I seem to be having an issue with 2.4 and linuxthreads.
> 
> I have a program that spawns a child thread, and that child boosts 
> itself into a realtime scheduler class.
> 
> The child then went crazy and turned into a cpu hog.  At this point, a 
> higher-priority task detected the hog, and tried to kill the process by 
> sending a "kill -9" to the main thread.  Unfortunately, it appears that 
> there is some kind of priority-inversion thing happening, as the process 
> did not die.
> 
> Is this expected behaviour?  Is there any way around this?  Do I need to 
> put the main thread at a higher priority than any of the child threads? 
>  What about the manager thread?
> 
> Thanks,
> 
> Chris

I believe that in the old LinuxThreads implementation the manager thread 
  is the one that handles all signals, so it may need its priority 
increased as well. NPTL threads likely handle this much better (there is 
no manager thread).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

