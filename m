Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVK3Fwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVK3Fwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 00:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVK3Fwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 00:52:37 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:60230 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751069AbVK3Fwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 00:52:36 -0500
Message-ID: <438D3E5C.6020900@m1k.net>
Date: Wed, 30 Nov 2005 00:53:32 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Shoemaker <c.shoemaker@cox.net>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <438C0124.3030700@m1k.net> <Pine.LNX.4.64.0511290808510.3177@g5.osdl.org> <438C80DD.7050809@m1k.net> <Pine.LNX.4.64.0511290835220.3177@g5.osdl.org> <20051129172534.GA4514@pe.Belkin>
In-Reply-To: <20051129172534.GA4514@pe.Belkin>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Shoemaker wrote:

>On Tue, Nov 29, 2005 at 08:38:48AM -0800, Linus Torvalds wrote:
>  
>
>>On Tue, 29 Nov 2005, Michael Krufky wrote:
>>    
>>
>>>In other words, the OOPS is the last thing to show on the screen in text mode,
>>>before the console switches into X, using debian sarge's default bootup
>>>process.
>>>      
>>>
>>Ok. Whatever it is, I'm happy it is doing that, since it caused us to see 
>>the oops quickly. None of _my_ boxes do that, obviously (and I tested on 
>>x86, x86-64 and ppc64 exactly to get reasonable coverage of what different 
>>architectures might do - but none of the boxes are debian-based).
>>
>>>I have no idea why gdb is running.... hmm... Anyhow, I'm away from that
>>>machine right now, and it is powered off, so I can't look directly at the
>>>startup scripts right now.  Would you like me to send more info later on when
>>>I get home?  If so, what would you like to see?
>>>      
>>>
>>It's not important, I was just curious about what strange things people 
>>have in their bootup scripts.  If you can just grep through the rc.d files 
>>to see what uses gdb, I'd just like to know...
>>    
>>
>I doubt gdb is in rc.d scripts.  My wild uninformed guess would be
>that some process (maybe xinit?) hit a SEGV and had its own signal
>handler installed that tried to call gdb and attach to the crashing
>process.  I could imagine something like that being useful for
>generating nice userspace stack traces to send to the developers.  I
>think I've seen something similar in some builds.
>
I think Chris is right.  There is no gdb in the scripts at all.  It 
makes sense for these debug capabilities to be present in Debian 
Sarge/Testing.

Nothing in my scripts look out-of-the-ordinary.

-Mike
