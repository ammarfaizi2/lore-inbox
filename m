Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310929AbSCHQGS>; Fri, 8 Mar 2002 11:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310928AbSCHQGI>; Fri, 8 Mar 2002 11:06:08 -0500
Received: from ns1.fast.net.uk ([212.42.162.2]:48913 "EHLO t2.fast.net.uk")
	by vger.kernel.org with ESMTP id <S310929AbSCHQGE>;
	Fri, 8 Mar 2002 11:06:04 -0500
Message-ID: <3C88E152.5070201@htec.demon.co.uk>
Date: Fri, 08 Mar 2002 16:05:38 +0000
From: Christopher Quinn <cq@htec.demon.co.uk>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Interprocess shared memory .... but file backed?
In-Reply-To: <Pine.LNX.4.33.0203081049360.15002-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

>>>well MAP_PRIVATE is "dont share" so not with that 8)
>>>Use MAP_SHARED and you'll get what you want
>>>
>>Certainly true! But MAP_SHARED gives uncontrolled flush of 
>>dirty data - so that's out for me. I only want 'privacy' to 
>>extend to the right to make changes permanent at my own 
>>discretion.
>>
> 
> right, and that's not what Unix provides.  in particular, mmap
> is a means for apps to be polite, not for them to strongarm
> the kernel.  in particular, if you mmap a file, much of the point
> is that the kernel chooses how much of the state is in ram or 
> on disk.  you can, of course, msync, or even munmap.
> 
> 
> 

Seems a bit restrictive to me. After all Unix is not an 
ossified standard! :)
Assuming clone() actually page table shares the vm covered 
by a mmap(MAP_PRIVATE) in the way I want, it isn't much to 
ask to be more *restrictive* on sharing?

So far, it's looking as if my ideal is unattainable with the 
current kernel.
Anyone disagree?


-- 
rgrds,
Chris Quinn

