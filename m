Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315368AbSEBTVv>; Thu, 2 May 2002 15:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSEBTVu>; Thu, 2 May 2002 15:21:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:2576 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S315368AbSEBTVt>;
	Thu, 2 May 2002 15:21:49 -0400
Message-ID: <3CD18318.7060407@evision-ventures.com>
Date: Thu, 02 May 2002 20:19:04 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: IDE hotplug support?
In-Reply-To: <Pine.LNX.4.44.0204301746020.2301-100000@mustard.heime.net> <20020426152943.A413@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Pavel Machek napisa?:
> Hi!
> 
> 
>>I came across a nice case from procase, supporting 16 IDE drives in 
>>(so-called?) hotplug frames. Problem is... How will linux trat this?
> 
> 
> Should be okay. Hdparm can force spindown and bus rescan, and that's 
> basically what you need.
> 
> 
>>I plan to use 15 drives in a RAID-5, assigning the last 16th drive as a 
>>spare.
> 
> 
> 8 controllers? hmmm...

15 drives == 16 interfaces == 8 channels == 4 controllers
with primary and secondary channel.

He will have groups of about 4 drives on each channel wich
serialize each other due to excessive IRQ line sharing and
master slave issues.

8 x 130MBy/s >>>> PCI bus throughput... I would rather recommend
a classical RAID controller card for this kind of
setup.

The request aliasing effects will be almost for sure disasterous
to overall system performance.

