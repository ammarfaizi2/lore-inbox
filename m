Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261949AbTC1DHt>; Thu, 27 Mar 2003 22:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261952AbTC1DHt>; Thu, 27 Mar 2003 22:07:49 -0500
Received: from ns0.usq.edu.au ([139.86.2.5]:57353 "EHLO ns0.usq.edu.au")
	by vger.kernel.org with ESMTP id <S261949AbTC1DHs>;
	Thu, 27 Mar 2003 22:07:48 -0500
Message-ID: <3E83BFC8.70901@usq.edu.au>
Date: Fri, 28 Mar 2003 13:21:44 +1000
From: Ron House <house@usq.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hdparm and removable IDE?
References: <Pine.LNX.3.96.1030326130640.8110B-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> On 26 Mar 2003, Alan Cox wrote:
> 
> 
>>IDE hotswap at drive level is not supported by Linux. It might work ok. 
>>Providing you shut the drive down fully and flush the cache before you
>>unregister/unplug and replug before registering the new interface
> 
> 
> There was a bunch of discussion of this, possibly on this list, and I
> believe that the whole cable has to be unregistered or some such. I've
> done it with only one drive on a cable, and it seemed to work. On the
> other hand I was only playing.

Thanks Bill, I have read everything I can find in the archives, but am 
still confused as to what exactly is going on. My current understanding is:

On boot, Linux examines the ide drive for physical parameters. Then, 
mounting causes filesystem details to be loaded.

Now clearly, unmounting should undo mounting (or does the kernel keep 
something even here in memory for 'efficiency?). So is hdparm -U enough 
to undo the loading of physical parameters, and will hdparm -R reload them?

> I've seen some note regarding using ide-floppy for the whole drive instead
> of the media, but I have never had the urge to try that.
> 
> WARNING: removable and hot swapable bays are not the same, had a client
> prove that to herself the hard way.

This device is claimed to be 'hot-swappable'. It has circuitry on board, 
which I presume does the necessary isolation and power down as claimed 
in the blurb.

As an aside, I am puzzled by statements that Linux `doesn't support' 
this. As far as I can see (and I acknowledge my relative ignorance, 
which is why I have appealed for help here), whatever is done at boot 
time can be done again later if conditions change, and it should be just 
a matter of my ascertaining exactly what must be done to achieve this. 
Or have I missed something very important (highly possible!)?

-- 
Ron House     house@usq.edu.au
               http://www.sci.usq.edu.au/staff/house

