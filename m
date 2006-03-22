Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751870AbWCVA0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbWCVA0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWCVA0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:26:05 -0500
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:61686 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751870AbWCVA0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:26:04 -0500
Message-ID: <44209997.9010708@comcast.net>
Date: Tue, 21 Mar 2006 19:25:59 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.6.16-rc6-ide1 irq trap, io hang problem solved?
References: <442089CB.1000008@comcast.net> <1142985995.4532.195.camel@mindpipe>
In-Reply-To: <1142985995.4532.195.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Tue, 2006-03-21 at 18:18 -0500, Ed Sweetman wrote:
>  
>
>>I've seen some traffic here to suggest that the problem was tracked 
>>down, but I saw nothing about it being solved completely.  Currently my 
>>system hangs whenever an irq trap message appears, usually after some 
>>sort of disk io on SATA drives. Is it fixed in the GIT patchset recently 
>>posted or is this still open?  
>>    
>>
>
>Are you referring to the "Losing ticks" bug?  What is the exact error
>message that you get?  Does the system hang momentarily or have to be
>rebooted?
>
>Lee
>
>
>  
>
No not the ticks bug.

ata3: irq trap
ata3: command 0x25 timeout, stat 0x50 host_stat 0x60
ata4: irq trap
ata4: command 0x25 timeout, stat 0x50 host_stat 0x20
ata4: irq trap
ata4: command 0x35 timeout, stat 0x50 host_stat 0x20
ata3: irq trap
ata3: command 0x35 timeout, stat 0x50 host_stat 0x60


Over and over in random orientations.   System hangs on io momentarily, 
usually a few seconds. No fs errors, no other errors given.   System 
also seems to have been kicked out of DMA mode at least for disks. 


