Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290807AbSBLRdk>; Tue, 12 Feb 2002 12:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290946AbSBLRda>; Tue, 12 Feb 2002 12:33:30 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:37333 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S290807AbSBLRdW>; Tue, 12 Feb 2002 12:33:22 -0500
Message-ID: <3C695035.6040902@antefacto.com>
Date: Tue, 12 Feb 2002 17:26:13 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <Pine.LNX.3.96.1020212113237.5657B-100000@gatekeeper.tmr.com> <E16ageE-0001Te-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On February 12, 2002 05:38 pm, Bill Davidsen wrote:
> 
>>On Tue, 12 Feb 2002, Daniel Phillips wrote:
>>
>>
>>>On February 11, 2002 08:05 pm, Bill Davidsen wrote:
>>>
>>>>Did I miss discussion of an option to put it somewhere other than as part
>>>>of the kernel? Sorry, I missed that.
>>>>
>>>It's a trick question?  The config option would let you specify that no 
>>>kernel config information at all would be stored with or in the kernel.  No 
>>>cost, no memory footprint.  And I would get to have the extra warm n fuzzy 
>>>usability I tend to go on at such lengths about.  So we're both happy, right? 
>>>
>>>I'd even remain happy if the option were set *off* by default.
>>>
>>No trick other than to read what I said in either of the previous posts...
>>the question was not how to avoid having the useful feature, but how to
>>put it somewhere to avoid increasing the kernel size. I suggested in the
>>modules directory, either as a text file or as a module.
>>
> 
> We are in violent agreement, I'm not sure where the misunderstanding came from.
> Yes, the leading idea is to put it in a module.  In fact a patch exists, though
> it may have issues, it's been a while since I looked at it.
> 
> Besides that, it's been suggested to stick it only the end of bzImage in a way
> that some utility can find it, so that it never gets loaded into memory or does
> and is immediately discarded.

I'd go for tacking it on at the end of the bzImage. Advantages would be
that it can be read even when the kernel isn't loaded, and also there
is no danger of loading a module in another kernel.

Padraig.

