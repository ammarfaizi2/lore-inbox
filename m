Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbTIDAA4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 20:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTIDAA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 20:00:56 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:3127 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S264357AbTIDAAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 20:00:54 -0400
Message-ID: <3F567F2C.3040707@rackable.com>
Date: Wed, 03 Sep 2003 16:54:20 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: "K. Hampf" <khampf@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: Verified IDE performance issues in kernels newer than 2.4.20
References: <200309040231.10040.khampf@users.sourceforge.net> <20030903234932.GA15327@DUK2.13thfloor.at>
In-Reply-To: <20030903234932.GA15327@DUK2.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Sep 2003 00:00:52.0278 (UTC) FILETIME=[9AF2BD60:01C37277]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:

>On Thu, Sep 04, 2003 at 02:31:10AM +0300, K. Hampf wrote:
>  
>
>>BRIEF:
>>I discovered the 2.4.21 and  2.4.22 kernels give me roughly 15% of the 
>>troughput compared to 2.4.20. Anyone working on this?
>>    
>>
>
>out of the blue, the following info could be very useful ...
>(for 2.4.20 and 2.4.22 on your systems)
>
>cat /proc/ide/*
>hdparm -i /dev/hd?
>hdparm /dev/hd?
>
>and try to make it available on a webpage
>  
>

  Also try "hdparm  -a 2048 <some device>" before running hdparm.  Also 
the ide section of dmesg woul dbe handy in addition to the above.

[root@goblin e2fsprogs-1.26]# hdparm  -t /dev/hdg

/dev/hdg:
 Timing buffered disk reads:   70 MB in  3.04 seconds =  23.03 MB/sec
[root@goblin e2fsprogs-1.26]# hdparm  -a 2048 /dev/hdg

/dev/hdg:
 setting fs readahead to 2048
 readahead    = 2048 (on)
[root@goblin e2fsprogs-1.26]# hdparm  -t /dev/hdg

/dev/hdg:
 Timing buffered disk reads:  122 MB in  3.01 seconds =  40.47 MB/sec




-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


