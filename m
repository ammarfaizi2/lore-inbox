Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbUKCW2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUKCW2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUKCW0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:26:24 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:62369 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261941AbUKCWPO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:15:14 -0500
Message-ID: <4189586E.2070409@verizon.net>
Date: Wed, 03 Nov 2004 17:15:10 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: DervishD <lkml@dervishd.net>
CC: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net> <200411031147.14179.gene.heskett@verizon.net> <20041103174459.GA23015@DervishD> <200411031353.39468.gene.heskett@verizon.net> <20041103192648.GA23274@DervishD>
In-Reply-To: <20041103192648.GA23274@DervishD>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [68.238.31.6] at Wed, 3 Nov 2004 16:15:10 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi Gene :)
> 
>  * Gene Heskett <gene.heskett@verizon.net> dixit:
> 
>>>   Then the children are reparented to 'init' and 'init' gets rid
>>>of them. That's the way UNIX behaves.
>>
>>Unforch, I've *never* had it work that way.  Any dead process I've 
>>ever had while running linux has only been disposable by a reboot.
> 
> 
>     Well, you know, shit happens... Anyway, could you define 'dead'?
> Because if you're talking about zombies whose parent dies, they're
> killable easily: just wait until init reaps them (usually in less
> than 5 minutes since they dead). If you are talking about zombies who
> has their parent alive, then it's a bug in the application, not the
> kernel. In fact I wouldn't like if the kernel reaps my children
> before I do, just in case I want to do something.
> 
>     If you're talking about unkillable processes (those stuck in
> disk-sleep state), you're right: only rebooting can kill them
> (although sometimes they go out of D state and die normally). Bad
> luck for you if any dead process you've ever had while running linux
> has been of this kind :(
> 

I did this to myself a number of times when I was first learning Samba - even an 
ls would become unkillable.  You couldn't rmmod smb, since it was in use, and you 
couldn't kill the process, since it was waiting on a syscall.  Ergh.

>     Raúl Núñez de Arenas Coronado
> 

