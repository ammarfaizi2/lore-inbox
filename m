Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTJCAH7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 20:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbTJCAH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 20:07:58 -0400
Received: from dyn-ctb-203-221-73-69.webone.com.au ([203.221.73.69]:30212 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263561AbTJCAH5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 20:07:57 -0400
Message-ID: <3F7CBDD4.7010503@cyberone.com.au>
Date: Fri, 03 Oct 2003 10:07:48 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: piotr@member.fsf.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test6
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <200309281703.53067.kernel@kolivas.org> <200309280502.36177.rob@landley.net> <3F77BB2C.7030402@cyberone.com.au> <3F7863F0.6070401@wmich.edu> <20031002004102.GB2013@81.38.200.176> <3F7B9600.408@cyberone.com.au> <20031002190744.GC1215@81.38.200.176>
In-Reply-To: <20031002190744.GC1215@81.38.200.176>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pedro Larroy wrote:

>On Thu, Oct 02, 2003 at 01:05:36PM +1000, Nick Piggin wrote:
>
>>
>>Pedro Larroy wrote:
>>
>>>Why not run xmms with SCHED_RR or SCHED_FIFO?
>>>
>>>
>>>
>>Well because playing an mp3 really is a pitiful task for modern CPUs,
>>and the standard scheduler should handle this fine. Also a music skip
>>isn't terribly important.
>>
>>Realtime applications are difficult to make robust and they can easily
>>hang the system.
>>
>>
>
>I think there are better aproaches for deciding when a task should be
>interactive than the current one based in how much does the task sleep.
>
>I'm afraid this selection criteria leads to a scheduler that isn't
>predictable for situations that aren't the ones for which is tuned to work.
>Of course I may be wrong, but to me, seems that saying explicitly 
>which tasks are interactive sounds better.
>

Have a look at my scheduler if you like. It won't estimate interactivity
but it works quite well if you nice -10 your X server. Ie. explicitly
state which process should be favoured.
http://www.kerneltrap.org/~npiggin/v15a/

