Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSLHVO2>; Sun, 8 Dec 2002 16:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbSLHVO2>; Sun, 8 Dec 2002 16:14:28 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:1495 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261545AbSLHVO2>;
	Sun, 8 Dec 2002 16:14:28 -0500
Message-ID: <3DF3B7FB.9010902@colorfullife.com>
Date: Sun, 08 Dec 2002 22:22:03 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: anton@samba.org
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-BK + 24 CPUs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton wrote:

>schedules:
> 56283 total
> 41984 pipe_wait
>  9746 do_work
>  1949 do_exit
>  1834 sys_wait4
>
>ie during the compile we scheduled 56283 times, and 41984 of them were
>caused by pipes.
>
The linux pipe implementation has only a page sized buffer - with 4 kB 
pages, transfering 1 MB through a pipe means at 512 context switches.

--
    Manfred

