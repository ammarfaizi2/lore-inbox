Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTKQFRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 00:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTKQFRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 00:17:09 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:45993 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263303AbTKQFRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 00:17:06 -0500
Message-ID: <3FB859CC.2040002@cyberone.com.au>
Date: Mon, 17 Nov 2003 16:17:00 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: Andrew Morton <akpm@osdl.org>, Gawain Lynch <gawain@freda.homelinux.org>,
       prakashpublic@gmx.de, linux-kernel@vger.kernel.org, cat@zip.com.au
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
References: <20031116192643.GB15439@zip.com.au> <200311162254.23043.gene.heskett@verizon.net> <3FB84C5A.3000705@cyberone.com.au> <200311162347.48739.gene.heskett@verizon.net>
In-Reply-To: <200311162347.48739.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Gene Heskett wrote:

>On Sunday 16 November 2003 23:19, Nick Piggin wrote:
>
>>I think you might have confused Andrew a bit more ;)
>>
>>To start with, you are talking about IO schedulers, while the thread
>>is about CPU interactivity.
>>
>
>I wasn't aware that such performance issues were divorced.  In my 
>admitted limited view, a laggy mouse is a laggy mouse, and its due to 
>irq latency in achieving the context switch to service the mouses 
>data.  To me, its sorta like 2=2. :)
>

I guess its mostly due to scheduling latency. I think IRQ latency is
generally very good these days.

Scheduling latency caused not by long critical sections in the kernel,
but having things scheduled in front of you (X) for a long time.

>
>>The problem here looks like something that is caused by something in
>>mm3, not in mm2, not linus.patch, and not
>>context-switch-accounting-fix.patch.
>>
>>
>>Off topic: it would be good if you could try the as disk scheduler
>>in mm3. I recall you had some problems with it earlier, but they
>>should be fixed in mm3. Thanks.
>>
>
>Ok Nick.  I'll reboot tomorrow without the elevator argument.  Right 
>now, amanda is fixin to be fired off in about 25 minutes and I want 
>to see how badly its estimate phase hogs the machine using the cfq 
>scheduler.  With the -mm2 as, it was almost psychedelic to watch the 
>mouse move.
>

OK thanks. I think this problem you were seeing _was_ interrupt latency
due to AS doing millions of WARNs. It should be fixed in mm3.

>
>Also off topic re mouse performance, and I expect this is an X issue, 
>but when its been blanked because I'm typing, it takes about a full 
>seconds worth of hand waving before it becomes visible again.  This 
>is an X issue and I should go away, right?
>

Sounds like it.


