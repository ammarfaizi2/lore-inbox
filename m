Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275009AbTHLCvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275007AbTHLCvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:51:55 -0400
Received: from dyn-ctb-210-9-241-99.webone.com.au ([210.9.241.99]:27652 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S275006AbTHLCvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:51:54 -0400
Message-ID: <3F385633.3090807@cyberone.com.au>
Date: Tue, 12 Aug 2003 12:51:31 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: rob@landley.net
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <200308052022.01377.kernel@kolivas.org> <3F2F87DA.7040103@cyberone.com.au> <200308110248.09399.rob@landley.net>
In-Reply-To: <200308110248.09399.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rob Landley wrote:

>On Tuesday 05 August 2003 06:32, Nick Piggin wrote:
>
>
>>But by employing the kernel's services in the shape of a blocking
>>syscall, all sleeps are intentional.
>>
>
>Wrong.  Some sleeps indicate "I have run out of stuff to do right now, I'm 
>going to wait for a timer or another process or something to wake me up with 
>new work".
>  
>
>
>Some sleeps indicate "ideally this would run on an enormous ramdisk attached 
>to gigabit ethernet, but hard drives and internet connections are just too 
>slow so my true CPU-hogness is hidden by the fact I'm running on a PC instead 
>of a mainframe."
>

I don't quite understand what you are getting at, but if you don't want to
sleep you should be able to use a non blocking syscall. But in some cases
I think there are times when you may not be able to use a non blocking call.
 
And if a process is a CPU hog, its a CPU hog. If its not its not. Doesn't
matter how it would behave on another system.




