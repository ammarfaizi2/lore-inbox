Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWJALeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWJALeP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWJALeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:34:15 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:49011 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751757AbWJALeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:34:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=gBOZesaYkkQA94jW8PMJm2ke8SqVp6MZv8ZYnstE+GR5duLnGM0gkWWNnBPzcjQTB4W18+7jcX3H4EC33FsaPiyVrdsztfqdHrw1AcbpyzLYehs+rbLsvqP/Zfth8v4F15IBygDYnU6v0FqnxVMa7X32utxN9A0FMhp8E2ev8+E=
In-Reply-To: <Pine.LNX.4.61.0609301908460.4615@yvahk01.tjqt.qr>
References: <0635847A-C149-412C-92B1-A974230381F8@dts.local> <F2F2C98F-6AFB-4E19-BEE9-D32652E2F478@atheme.org> <EE7C757E-E2CE-4617-A1D4-3B8F5E3E8240@gmail.com> <Pine.LNX.4.61.0609291905550.27518@yvahk01.tjqt.qr> <CF74CE5D-42A1-4FF9-8C9B-682C5D6DEAE1@gmail.com> <Pine.LNX.4.61.0609292011190.634@yvahk01.tjqt.qr> <BEC70F7E-6143-4D8D-9800-A8538A152A18@gmail.com> <m1mz8ii8wj.fsf@ebiederm.dsl.xmission.com> <E78297DA-5F0F-40FA-A008-89264570B313@gmail.com> <Pine.LNX.4.61.0609301908460.4615@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FD5311BD-3DE3-4185-B093-CE05199F09C7@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       William Pitcock <nenolod@atheme.org>
Content-Transfer-Encoding: 7bit
From: girish <girishvg@gmail.com>
Subject: Re: [PATCH] include children count, in Threads: field present in /proc/<pid>/status (take-3)
Date: Sun, 1 Oct 2006 20:34:30 +0900
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.749)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  PID COMMAND      %CPU   TIME   #TH #PRTS #MREGS RPRVT  RSHRD   
>> RSIZE  VSIZE
>> 22429 top         16.6%  0:21.12   1    18    20  1.35M   684K   
>> 1.77M  26.9M
>> --------------------------------------------------------------------- 
>> ---
>> --------------------------------------------------------
>>
>> Comments/opinions?
>
> I fail to see which column you mean.
>
> #TH perhaps? I think, that can be calculated under linux by
>
>  (a) counting the directories in /proc/22429/task using readdir
> or

I have implemented the child_count script, in this way. I was  
wondering what is more convenient.


>  (b) get the nlink of /proc/22429/task and subtract 2, which should  
> give
>      the same as (a), and, better than (a), should also be atomic

This one, is good. I did not think about this approach. 
