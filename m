Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSFGIdb>; Fri, 7 Jun 2002 04:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317234AbSFGIda>; Fri, 7 Jun 2002 04:33:30 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:60687 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S317232AbSFGIda>; Fri, 7 Jun 2002 04:33:30 -0400
Message-ID: <3D00706B.1070906@loewe-komp.de>
Date: Fri, 07 Jun 2002 10:35:55 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Vladimir Zidar <vladimir@mindnever.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Process-Shared Mutex (futex) - What is it good for ?
In-Reply-To: <1023380463.1751.39.camel@server1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Zidar wrote:
>  Nice to have everything as POSIX says, but how could process-shared
> mutex be usefull ? Imagine two processes useing one mutex to lock shared
> memory area. One process locks, and then dies (for example, it goes
> sigSEGV way). Second process could wait for ages (untill reboot ?) and
> it won't get lock() on that mutex ever. Wouldn't it be more usefull to
> have automatic mutex cleanup after process death ? Just make a cleanup,
> and mark it as 'damaged', so other processes will eventualy get error
> saying that something went wrong.
> 
> 

Look at kernel/futex.c in 2.5 tree.
I vote for killing the "dangling" process - like it's done in IRIX.





