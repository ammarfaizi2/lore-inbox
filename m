Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315392AbSEBUPI>; Thu, 2 May 2002 16:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315397AbSEBUPG>; Thu, 2 May 2002 16:15:06 -0400
Received: from host.greatconnect.com ([209.239.40.135]:20228 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S315392AbSEBUO7>; Thu, 2 May 2002 16:14:59 -0400
Message-ID: <3CD19D16.7070605@rackable.com>
Date: Thu, 02 May 2002 13:09:58 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: =?ISO-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: IDE hotplug support?
In-Reply-To: <Pine.LNX.4.44.0204301746020.2301-100000@mustard.heime.net> <20020426152943.A413@toy.ucw.cz> <3CD18318.7060407@evision-ventures.com> <20020502215833.V31556@unthought.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Why not just grab a pair of 8 port 3ware cards?  Run raid 5 on each 
card, and throw 0 or linear via the md driver on top?

Jakob Østergaard wrote:

>On Thu, May 02, 2002 at 08:19:04PM +0200, Martin Dalecki wrote:
>...
>  
>
>>15 drives == 16 interfaces == 8 channels == 4 controllers
>>with primary and secondary channel.
>>    
>>
>
>Usually using both master and slave on an IDE channel spells disaster
>performance wise, and I would be surprised if the hotplug stuff worked
>with this as well...
>
>  
>
>>He will have groups of about 4 drives on each channel wich
>>serialize each other due to excessive IRQ line sharing and
>>master slave issues.
>>    
>>
>
>Use 8 controllers for the 15 (16) drives.
>
>  
>
>>8 x 130MBy/s >>>> PCI bus throughput... I would rather recommend
>>a classical RAID controller card for this kind of
>>setup.
>>    
>>
>
>Because RAID controllers do not use the PCI bus ???    ;)
>
>The bus-overhead on RAID-5 is not too bad unless you specifically construct
>a workload to make it so (writes-only, scattered so that the kernel cannot
>cache stripes to avoid read-in for parity calculation).
>
>Sure, the PCI bus will be a bottleneck, and PCI overhead alone will decrease
>the real-world performance to somewhere below the theoretical PCI bandwidth
>limitations, but don't let this blind you  -  100 MB/sec sustained transfers
>can still be "good enough" for many people.
>
>By the way, has anyone tried such larger multi-controller setups, and tested
>the bandwidth in configurations with multiple PCI busses on the board, versus a
>single PCI bus ?
>
>  
>


