Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317162AbSEXPON>; Fri, 24 May 2002 11:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317165AbSEXPOM>; Fri, 24 May 2002 11:14:12 -0400
Received: from [195.63.194.11] ([195.63.194.11]:38927 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317162AbSEXPOK>; Fri, 24 May 2002 11:14:10 -0400
Message-ID: <3CEE49C3.4050202@evision-ventures.com>
Date: Fri, 24 May 2002 16:10:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: Quota patches
In-Reply-To: <20020523091626.GA8683@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0205231002460.1006-100000@home.transmeta.com> <20020524123510.A180298@wobbly.melbourne.sgi.com> <20020524145817.GC31925@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jan Kara napisa?:
>   Hi all,
>   
> 
>>On Thu, May 23, 2002 at 10:03:50AM -0700, Linus Torvalds wrote:
>>
>>>On Thu, 23 May 2002, Jan Kara wrote:
>>>
>>>>... . If he has newer tools
>>>>(<3.05) he has to decide depending on format he wants to use...
>>>
>>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>>
>>>This makes me pretty certain we just do not want to have the backwards-
>>>compatibility layer in 2.5.x
>>>
>>>Are there _any_ reasons to use the old stuff, if the fix is just to
>>>upgrade to a newer quota tool?
>>
>>Moving to newer interfaces implies use of the new ondisk format
>>for the quota files (exclusively) - I'd imagine that's the main
>>reason behind providing a choice.  Whether or not that reason is
>>sufficently compelling though... dunno.  If one wanted to be able
>>to switch between booting either 2.4 (unpatched) and 2.5+, and
>>also maintain quota information on filestystems, then the choice
>>would be useful in that situation.
> 
>   Latest quota interface is able to handle both formats together
> (structures passed throught Q_GETQUOTA, Q_SETQUOTA,... are independent
> of quota format and Q_QUOTAON takes as an argument in 'id' the quota format
> number). So if user wants to stay at old format he can...
>   So I think Linus is right here that there's no real reason for keeping
> compatibility code in 2.5... Linus, I'll send you the patch which kicks
> out the compatibility stuff.

As a side note:

If we can do it for quota - we could possible remove the
IPC_OLD variant away as well. It's looong overdue by now,
becouse the IPC_OLD was not standard conformant anyway.

I would be really really glad to do it iff ACK-ed.

