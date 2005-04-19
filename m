Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVDSXjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVDSXjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 19:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVDSXjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 19:39:21 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:4309 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261282AbVDSXjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 19:39:13 -0400
Message-ID: <42659673.9080901@nortel.com>
Date: Tue, 19 Apr 2005 17:38:27 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on 2.4 scheduler, threads, and priority inversion
References: <3V45v-tx-39@gated-at.bofh.it> <426594B1.9000307@shaw.ca>
In-Reply-To: <426594B1.9000307@shaw.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:

> I believe that in the old LinuxThreads implementation the manager thread 
>  is the one that handles all signals, so it may need its priority 
> increased as well. NPTL threads likely handle this much better (there is 
> no manager thread).

Some experimenting leads me to believe that both the main thread and the 
manager thread must be of higher priority than the cpu hogging thread, 
otherwise priority inversion issues occur.

I was fairly shocked that even a "kill -9" failed to work though...

Chris

