Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUBRSq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267439AbUBRSq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:46:26 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:29399
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S267821AbUBRSpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:45:06 -0500
Message-ID: <4033AE69.9050400@tmr.com>
Date: Wed, 18 Feb 2004 13:26:49 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: JG <jg@cms.ac>, linux-kernel@vger.kernel.org
Subject: Re: could someone plz explain those ext3/hard disk errors
References: <20040209095227.AF4261A9ACF@23.cms.ac> <200402091026.i19AQ15t000678@81-2-122-30.bradfords.org.uk> <4033691F.7070804@tmr.com> <200402181442.i1IEgwF2000170@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200402181442.i1IEgwF2000170@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Quote from Bill Davidsen <davidsen@tmr.com>:
> 
>>John Bradford wrote:
>>
>>>>now...hm, it all started when i upgraded from kernel 2.4.19 to 2.6.0
>>>>in late decemeber, the system worked very fine for a week or so
>>>>(having great response times!) but then all of a sudden the problems
>>>>started. 2 disks died. then my gigabit network card was only able to
>>>>transmit 200kb/s (but this was really a hardware problem, a new card
>>>>is working fine again, well...). a week later the next disks are
>>>>having problems and i have yet to RMA three disks. and now the next
>>>>two disks..., i'm getting insane ;) i can't see any EXT3 error anymore
>>>>*g* the next disks will be reiserfs only to see other error messages
>>>>;) well, but that doesn't solve the problem of 6 disks within 2
>>>>months...this is so unlikely.
>>>
>>>
>>>Please read the FAQ, fix your mail application - you are sending long
>>>lines, and don't break the CC list.
>>>
>>>As to your problem, look at the LBA sector addresses in the error
>>>message:
>>>
>>>280923064991615
>>>
>>>is your drive really over 100 EB?  No...
>>
>>I think we could assume that (a) he never told the kernel the disk was 
>>"over 100 EB" and (b) the kernel was trying to use that LBA anyway. 
>>Which could be due to either a kernel bug or memory corruption (or CPU 
>>problems, but unlikely).
> 
> 
> What I was trying to point out is that the error message is clearly
> the result of a problem elsewhere.  Unless the drive firmware is
> buggy, or something very strange is going on inside the drive, (bad
> internal RAM or something like that), then the kernel did send a
> request for a sector which is well out of range.  What caused that
> request we don't know - quite possibly corruption of some filesystem
> structure on the disk caused that request, but it's important to be
> clear that the error message is the expected response to a request for
> such a high block number, and doesn't within itself indicate a problem
> with the disk.
> 
> I.E. Even though there is every chance that the drive is faulty, the
> posted error message doesn't indicate a drive failiure in itself, and
> you should look elsewhere.

Yes, I think we are saying the same thing, and by now hopefully the O.P. 
has gotten that. I suspect non-disk cause, just my guess.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
