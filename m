Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312083AbSCXWV6>; Sun, 24 Mar 2002 17:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312085AbSCXWVs>; Sun, 24 Mar 2002 17:21:48 -0500
Received: from mout1.freenet.de ([194.97.50.132]:50359 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S312083AbSCXWVg>;
	Sun, 24 Mar 2002 17:21:36 -0500
Message-ID: <3C9E51FC.8030503@freenet.de>
Date: Sun, 24 Mar 2002 23:23:56 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020323
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <Pine.LNX.4.44L.0203241029000.18660-100000@imladris.surriel.com> <3C9DDDEE.3000401@athlon.maya.org> <3C9E48B8.9080707@ngforever.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:
> Hi,
> 
>> Maybe, it would be possible to sort all known processes by there 
>> memory usage and combine it with the speed of their memoryrequests.
>> If memory gets low, and there is a process, which suddenly requests a 
>> lot of memory, this process get's killed, even if there is another 
>> process, which has three times more memory allocated then the "fast 
>> growing" process. If all processes are growing nearly equal and memory 
>> gets low, the process with the most memory usage get's killed - 
>> because with this process, the kernel achieves the target (to get free 
>> memspace) best.
> 
> So what if I want to malloc() say 100 MiBs at once? I'll get into 
> trouble then, because if I don't malloc() with sleep()s I get killed. 
> That's perfect performance then.

Only if there's not enough free memory. You can't get more memory then 
the machine has.
The mechanism gets active only when there isn't enough free memory for 
your request.


Regards,
Andreas Hartmann

