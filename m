Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTJKQzW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 12:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263342AbTJKQzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 12:55:22 -0400
Received: from zeus.kernel.org ([204.152.189.113]:51361 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263330AbTJKQzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 12:55:18 -0400
Message-ID: <3F882D05.2050908@colorfullife.com>
Date: Sat, 11 Oct 2003 18:17:09 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] SMP races in the timer code, timer-fix-2.6.0-test7-A0
References: <3F881B46.6070301@colorfullife.com> <Pine.LNX.4.56.0310111713440.8641@earth> <Pine.LNX.4.56.0310111807590.10679@earth>
In-Reply-To: <Pine.LNX.4.56.0310111807590.10679@earth>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>On Sat, 11 Oct 2003, Ingo Molnar wrote:
>
>  
>
>>since this would be the 8th word-sized field in struct timer_list,
>>making it a nice round structure size.
>>    
>>
>
>it's the 9th field in fact, due to timer->magic.
>  
>
I found one problem: the same timer can run on multiple cpus at the same time.

timer on cpu 0. running on cpu 0.
add_timer on cpu 1. expires immediately. running on cpu 1.

Your mail arrived out of order - thus I don't know yet if the 9th field 
is a counter or a flag - a counter might work, but is quite ugly.

--
    Manfred

