Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbVKRSoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbVKRSoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbVKRSoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:44:04 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:13517 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1161117AbVKRSoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:44:03 -0500
Message-ID: <437E215E.30500@tmr.com>
Date: Fri, 18 Nov 2005 13:45:50 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: bart@samwel.tk, linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
References: <20051116181612.GA9231@knautsch.gondor.com> <20051117223340.GD14597@elf.ucw.cz>
In-Reply-To: <20051117223340.GD14597@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>let me start by stating that the following is mainly guessed. I may be
>>completely wrong. Still I think you may be interested in my
>>observations, and perhaps you already got similar reports?
>>
>>On my laptop, running 2.6.14, I'm observing some strange file- and
>>filesystem corruptions. First, I thought it may have been caused by an
>>ext3 bug because the first corruption I did observe happened shortly
>>after an ext3 journal replay.
>>
>>I did report this to linux-kernel, but without any helpful response:
>>http://www.ussg.iu.edu/hypermail/linux/kernel/0511.0/0129.html
>>(Subject: ext3 corruption: "JBD: no valid journal superblock found")
>>
>>But now, I got another hint pointing to a possible cause of this
>>problem: I found a file - /usr/lib/libatlas.so.3.0 - which was corrupted
>>by 4k of it being overwritten by a different file, which I recognized. 
>>And that file happened to be an uncompressed manual page.
>>
>>As usually the manual pages are only stored compressed, this must have
>>happened when I actually did look at that manual page, which causes the
>>uncompressed version to be written to a file in /tmp/. And the best is:
>>I actually remember when I did read that man page, and it was while the
>>notebook ran on battery power, which is quite seldom. On battery power,
>>I have laptop mode activated and the hard disk spun down after a short
>>idle time.
>>
>>Why do I think this is related to the corruption? Well, on the one hand,
>>I'm compiling kernels quite often, tracking linus' git repository,
>>and
> 
> 
> Can you try some filesystem test while forcing disk spindowns via
> hdparm?
> 
> It may be bug in laptop mode, or a bug in ide (or something
> related)... trying spindowns without laptopmode would be helpful.
> 
I don't know if it would be helpful, but I run several servers with 
multiple drives, usually 4-5, some of which are in RAID and some aren't, 
and they all spin down and restart without problems many times a day. 
The kernel is 2.6.14.? with one patch to get my unsupported VIA IDE working.

My laptop also has a spindown (five min from memory) and I have yet to 
have a problem with it. Don't know if any of that is "spindowns without 
laptopmode" in a useful sense.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
