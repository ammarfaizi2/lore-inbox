Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVBVMiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVBVMiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVBVMiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:38:17 -0500
Received: from mta9.adelphia.net ([68.168.78.199]:22431 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S262286AbVBVMiB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:38:01 -0500
Message-ID: <421B272E.7000001@nodivisions.com>
Date: Tue, 22 Feb 2005 07:35:58 -0500
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
References: <421A3414.2020508@nodivisions.com> <421B12DB.70603@aitel.hist.no> <421B14A8.3000501@nodivisions.com> <200502221426.58973.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200502221426.58973.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
>>>The infrastructure for that does not exist, so instead, the "killed" 
>>>process remains. Not all of it, but at least the memory pinned down by 
>>>the io request.  This overhead is typically small, and the overehad of 
>>>adding forced io abort to every driver might
>>>be larger than a handful of stuck processes.  It looks ugly, but perhaps 
>>>a ps flag that hides the ugly processes is enough.
>>
>>I don't care about any overhead associated with stuck processes, nor do I 
>>care that they look ugly in the ps output.  What I care about is the fact 
>>that at least once a week on multiple systems with different hardware, some 
>>HW-related driver/process gets stuck, then immediately cascades its 
>>stuckness up to udevd or hald, and then I can't use any of my hardware 
>>anymore until I reboot.
> 
> 
> This was discussed to death before. There will never be a "D-state" killer. Period.
> 
> If you want to get rid of your stuck processes, you need to fix the bug
> or at least let lkml people know about it (this was already explained to you!).

I didn't mention any of that here; my reply was simply to correct Helge's 
misunderstanding about why I dislike stuck processes.  Regardless of whether 
the bugs get fixed or the kernel finds a way to work around them, my dislike 
has nothing to do with the overhead or "ugliness" of stuck processes; I 
dislike them because they render my system useless for 75% of the things I 
use it for.

-Anthony DiSante
http://nodivisions.com/
