Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVFZAl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVFZAl3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 20:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVFZAl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 20:41:29 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:8546 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261191AbVFZAja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 20:39:30 -0400
Message-ID: <42BDF93F.4050205@blueyonder.co.uk>
Date: Sun, 26 Jun 2005 01:39:27 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: georgek@netwrx1.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem compiling 2.6.12
References: <Pine.LNX.4.62.0506240856460.10920@eagle.netwrx1.com> <42BC1C43.3040505@blueyonder.co.uk> <Pine.LNX.4.62.0506241258500.20958@eagle.netwrx1.com> <42BC9FF1.1010400@blueyonder.co.uk> <5nerb117olj7kahv0k8b1vss382ini6bfr@4ax.com>
In-Reply-To: <5nerb117olj7kahv0k8b1vss382ini6bfr@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jun 2005 00:40:08.0387 (UTC) FILETIME=[9A593130:01C579E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George R. Kasica wrote:
> Sid:
> 
> That seems to have got it!!
> 
> Any kernel tuning or optimizations you'd care to recommend?
> 
I've tried a few from time to time, but nothing permanent. I can't 
off-hand remember them, but a google search turns up some options.

> In the future what do I do here or will this continue to work?
> 
As a permanent solution, as suggested in my other email, copying the 
stuff from /usr/include/{linux, asm, asm-generic} to /usr/local/include/ 
seems preferable to making symlinks for every new kernel.

> Thank you SO much, now I remember why I like linux. Helpful people
> like yourself.
> 
> 
> George
> 
> 
As a friend often says, "One hand washes the other", a maxim never more 
true or apt than when applied to Linux and opensource in general.
Regards
Sid.

> 
>>On Sat, 25 Jun 2005 01:06:09 +0100, you wrote:
> 
> 
>>George Kasica wrote:
>>
>>>>Try "ln -s /usr/src/linux-2.6.12/include/linux /usr/local/include" and 
>>>>"ln -s /usr/src/linux-2.6.12/include/asm /usr/local/include", see if 
>>>>it resolves the problem, I expect it will find them. If you still have 
>>>>problems, try "rm /usr/local/include/asm" and "ln -s 
>>>>/usr/src/linux-2.6.12/include/asm-i386 /usr/local/include/asm".
>>>
>>>
>>>Here are the links in /usr/local/include:
>>>
>>>lrwxrwxrwx    1 root     root           35 Jun 24 12:55 asm -> 
>>>/usr/src/linux-2.6.12/include/linux
>>>lrwxrwxrwx    1 root     root           35 Jun 24 12:55 asm-i386 -> 
>>>/usr/src/linux-2.6.12/include/linux
>>>lrwxrwxrwx    1 root     root           35 Jun 24 12:56 linux -> 
>>>/usr/src/linux-2.6.12/include/linux
>>>
>>>
>>>Well, it got further with the links as shown here:
>>>
>>># cd /usr/src/linux-2.6.12.1
>>># make oldconfig
>>>  HOSTCC  scripts/basic/split-include
>>>  HOSTCC  scripts/basic/docproc
>>>  SHIPPED scripts/kconfig/zconf.tab.h
>>>  HOSTCC  scripts/kconfig/conf.o
>>>  HOSTCC  scripts/kconfig/kxgettext.o
>>>  HOSTCC  scripts/kconfig/mconf.o
>>>scripts/kconfig/mconf.c: In function `exec_conf':
>>>scripts/kconfig/mconf.c:486: `EINTR' undeclared (first use in this 
>>>function)
>>>scripts/kconfig/mconf.c:486: (Each undeclared identifier is reported 
>>>only once
>>>scripts/kconfig/mconf.c:486: for each function it appears in.)
>>>scripts/kconfig/mconf.c:486: `EAGAIN' undeclared (first use in this 
>>>function)
>>>make[1]: *** [scripts/kconfig/mconf.o] Error 1
>>>make: *** [oldconfig] Error 2
>>>
>>>But still no joy.
>>>
>>>What now?
>>>
>>>George
>>>
>>>
>>>
>>
>>OK, "ln -s /usr/src/linux-2.6.12.1/include/asm-generic /usr/include".
>>Regards
>>Sid.
> 
> 
> 
> 


-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
