Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264046AbTEGPVe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTEGPVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:21:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25841 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264046AbTEGPVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:21:30 -0400
Message-ID: <3EB92747.2070204@mvista.com>
Date: Wed, 07 May 2003 08:33:27 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: sam@ravnborg.org, akpm@zip.com.au, kbuild-devel@lists.sourceforge.net,
       mec@shout.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic magic
References: <3EB8D36E.10206@mvista.com>	<20030507143059.GA1057@mars.ravnborg.org>	<3EB92176.8010803@mvista.com> <20030507.070646.54208027.davem@redhat.com>
In-Reply-To: <20030507.070646.54208027.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: george anzinger <george@mvista.com>
>    Date: Wed, 07 May 2003 08:08:38 -0700
>    
>    Also, if you are introducing a file with asm code, you either cause
>    all "other" archs to fail (till they catch up) or you must
>    introduce the simple one line file in each arch.
> 
> This is desirable behavior, then the arch maintainer sees the breakage
> and if the asm-generic solution is appropriate he makes that
> decision.
> 
> I don't think you want to play expert for port maintainers.
> 
> I sense that you want to be able to do "instant ports" to
> some architecture.  This isn't the way to do it.  Instead
> tar up a template set of asm-foo/ header files, and dump that
> into the directory for your new port.

For the record, I don't and have not done ports.

Rather I was interested in introducing a scaled math header.  It would 
contain routines to allow access to the 64 bit mpy and div 
instructions, which ,of course, can be done in C but, if you don't 
want the 64-bit lib, must be done with a rather large bit of code to 
do simple s32=s64/s32 and s32=s64%s32 calculations.  And, on 64-bit 
archs the whole problem goes away.
> 
> I see absolutely no value whatsoever to what you are proposing.
> In fact, I frankly think it sucks. :(

I understand what you think, but don't understand why you think that :(
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

