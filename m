Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVGLXaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVGLXaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVGLXaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:30:13 -0400
Received: from delta.securenet-server.net ([72.9.248.26]:64395 "EHLO
	delta.securenet-server.net") by vger.kernel.org with ESMTP
	id S262444AbVGLXaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:30:04 -0400
Message-ID: <42D4526E.2040409@machinehasnoagenda.com>
Date: Wed, 13 Jul 2005 09:29:50 +1000
From: "Shayne O'Connor" <forums@machinehasnoagenda.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: A list for linux audio users <linux-audio-user@music.columbia.edu>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-user] Problems appling realtime preempt patch to
 2.6.12
References: <42D38C00.1040800@telus.net>	<42D3C152.2010602@machinehasnoagenda.com>	<42D420B9.5070401@telus.net> <1121200732.10580.19.camel@mindpipe> <42D42F9A.40806@telus.net>
In-Reply-To: <42D42F9A.40806@telus.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: forums@machinehasnoagenda.com,machine@machinehasnoagenda.com,shunichi@machinehasnoagenda.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - delta.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - machinehasnoagenda.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Iain Duncan wrote:
>>>> yeah, i got this as well ... hasn't seemed to have any noticeable 
>>>> effects, though.
>>>
>>>
>>> Huh? Does that mean the kernel image is built anyway? I was under the 
>>> impression that it meant it didn't finish compiling? Am I confused?
>>
>>
>>
>> If the error was in building a module that you don't use, then it would
>> be harmless.  This seems to be the case.
> 
> 
> Ah, excuse my ignorance please, but does that mean the rest *did* build, 
> or I need to somehow comment out building that module and do it again? 
> And if so, how would I do that? In the kernel makefile?
> 

hmmm ... when i built mine, i didn't get that message until doing:

sudo make modules_install

... it went through the process of installing the modules, and then - 
the very last line - it gave me:

> : undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores' 

and it also gave me the same deal when doing:

sudo make install.

so, unless it compiled all the drivers/modules *before* exiting with 
error, i would try to find out the driver/module that is failing to 
compile, assess whether you need it or not, and try again (using "make 
gconfig").


shayne
