Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282690AbRLMJa3>; Thu, 13 Dec 2001 04:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283777AbRLMJaU>; Thu, 13 Dec 2001 04:30:20 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:48398 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S282690AbRLMJaN>; Thu, 13 Dec 2001 04:30:13 -0500
Message-ID: <3C1874D5.5050205@namesys.com>
Date: Thu, 13 Dec 2001 12:28:53 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
CC: Stewart Allen <stewart@neuron.com>, linux-kernel@vger.kernel.org
Subject: Re: passing params to boot readonly
In-Reply-To: <3C1841BB.8010003@neuron.com> <E16EPYW-0003nW-00@phalynx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Cumming wrote:

>On December 12, 2001 21:50, Stewart Allen wrote:
>
>>I'm in a bit of a pickle and need to find a way to pass boot params to a
>>reiserfs rootfs to *prevent* it from replaying the journal on single-user
>>boot. This may seem like a strange request, but I've got a degraded RAID
>>array that I need to poke around in before deciding whether or not to send
>>a disk off to a rehab lab. If the replay occurs, it will potentially
>>destroy the fs since I'm using a degraded snapshot of the failed disk in
>>hopes of reclaiming *some* of my data. The system is running 2.2.x (can't
>>remember and can't find out w/out booting).
>>
>>Do I have a snowball's chance of pulling this off?
>>
>
>Well, kinda. The only thing that can deter ReiserFS from replaying the 
>journal is convincing it that the physical media it's on is actually read 
>only. Some quick less/grep work revealed that there is no option that makes 
>the SCSI subsystem claim its devices are readonly (although it'd be extremely 
>useful for situations such as this).
>
>It'd probably be pretty easy to make a boot disk using a hacked version of 
>ReiserFS that refuses to replay the journal, by adding a "return 0;" near the 
>top of journal_read(struct super_block *) in journal.c. However, you might 
>feel more comfortable sending it off for data recovery than testing kernel 
>hacks on it ;)
>
>-Ryan
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
why not just edit the source code directly and recompile?  

Hans


