Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUBRDZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUBRDZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:25:53 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:4565 "EHLO
	gaimboi.tmr.com") by vger.kernel.org with ESMTP id S261681AbUBRDZv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:25:51 -0500
Message-ID: <4032D6E6.1060906@tmr.com>
Date: Tue, 17 Feb 2004 22:07:18 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bas Mevissen <ml@basmevissen.nl>
CC: "Theodore Ts'o" <tytso@mit.edu>, Jan Dittmer <j.dittmer@portrix.net>,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org> <4010D9C1.50508@portrix.net> <20040127190813.GC22933@thunk.org> <401794F4.80701@portrix.net> <20040129114400.GA27702@thunk.org> <4020BA67.9020604@basmevissen.nl> <20040206191840.GB2459@thunk.org> <40274AEF.8040600@basmevissen.nl>
In-Reply-To: <40274AEF.8040600@basmevissen.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bas Mevissen wrote:
> Theodore Ts'o wrote:
> 
>>
>> Was it just the permissions screwy?  Was the contents of these files
>> with the "funny" permission sane, or did they contain garbage?  What
>> about the modtime of the files?
>>
> 
> Only permissions. Something like r-Sr-S--- . File  contents were OK.
> 
>> The question is whether the problems you are seeing seem to be caused
>> by wholesale corruption of an entire block of the inode table, or is
>> some other kind of problem.  For example, if only the permissions are
>> getting screwed up, when the rest of the inode data is correct, then
>> yes, it would most likely be a filesystem bug.  I haven't noticed any
>> such problem myself, but it's possible that something like that might
>> be going on.  On the other hand, if it is an entire block in the inode
>> table getting corrupted then I'd be less likely to presume it to be a
>> filesystem flaw.
>>
> 
> It looks like this only appeared once. The FS looks fine now. So I guess 
>  I won't be able to reproduce it. Let's just go to 2.6.[23] and see if 
> it happens again.

Did this go away on reboot, or did you have to fix it? If it went away 
on reboot, it could be that the copy of the inode in memory was borked.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
