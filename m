Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314092AbSDQOa4>; Wed, 17 Apr 2002 10:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314093AbSDQOaz>; Wed, 17 Apr 2002 10:30:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:32519 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314092AbSDQOay>; Wed, 17 Apr 2002 10:30:54 -0400
Message-ID: <3CBD7889.6060707@evision-ventures.com>
Date: Wed, 17 Apr 2002 15:28:41 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 IDE oops (TCQ breakage?)
In-Reply-To: <200204161749.TAA16333@harpo.it.uu.se> <3CBD45BD.4040209@evision-ventures.com> <20020417120817.GA800@suse.de> <20020417122502.GB800@suse.de> <3CBD5D93.30501@evision-ventures.com> <20020417141653.GA13627@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Wed Apr 17, 2002 at 01:33:39PM +0200, Martin Dalecki wrote:
> 
>>Yes I see. However for now I will just concentrate on ide-cd.c and
>>await you to merge up with IDE 37 OK? (It should be easy this time :-).
> 
> 
> While working on ide-cd, I think the bad sector handling needs
> serious attention...  For example, I have a CD-ROM (a toddler
> game for windoz) that my 2 year old son scratched into
> non-functional oblivion.  I attempted to extract the contents in
> the hope of burning it to a new CD.  Using dd conv=noerror, it
> began ripping the content just fine -- till it hit the bad spot.
> Then it took like 12 hours to progress by an additional 10 MB...
> 
> Looking at the ide-cd code (since I used to maintain it years
> ago) it seems that on a bad sector, ide-cd retries ERROR_MAX (8)
> times.  But the low level ide driver is _also_ doing ERROR_MAX
> retries for each of those 8 retries from ide-cd....   Do we
> really need to retry 64 times when the drive told us clearly the
> _first_ time that it is an uncorrectable medium error?  
> 
> Perhaps something like this patch would make more sense?  With
> this patch is place, error handling is still awful, but at least
> a dd was able to make a bit of progress....  

Yeep you are entierly right. I will include your patch directly.


