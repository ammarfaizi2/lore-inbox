Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313615AbSDPGNa>; Tue, 16 Apr 2002 02:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313617AbSDPGN3>; Tue, 16 Apr 2002 02:13:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:60421 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313615AbSDPGN2>; Tue, 16 Apr 2002 02:13:28 -0400
Message-ID: <3CBBB270.2090006@evision-ventures.com>
Date: Tue, 16 Apr 2002 07:11:12 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <274A9BD5C76@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> On 15 Apr 02 at 18:44, Jens Axboe wrote:
> 
> 
>>>You can run a IDENTIFY_DEVICE from user space with the task ioctls and
>>>look at word 83 -- bit 1 and 14 must be set for TCQ to be supported. If
>>>you give me the model identifier from the IBM drive, I can tell you if
>>>it has tcq or not...
>>>
>>>I'll write a small util to detect this tomorrow and send it to you + the
>>>list.
>>
>>Duh, you can of course just look at /proc/ide/ideX/hdY/identify and
>>parse that. The info above is still valid for that, of course :-)
> 
> 
> If I parsed file correctly (it is 83 decimal word, yes?), WD's
> WDC WD1200JB-00CRA0 supports TCQ too. I'm still deciding which of
> TCQ #X and IDE #YY patches should be aplied to 2.5.8 to get optimal
> results (and I have to disconnect slaves...).

IDE 35 ist the latest from Jens with a fix for a wrong memset.
So you should go for IDE 34, 35, since they apply on top of each other.

