Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTKMLmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 06:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTKMLmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 06:42:24 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:4226 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263893AbTKMLmV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 06:42:21 -0500
Message-ID: <3FB36E18.2030105@cyberone.com.au>
Date: Thu, 13 Nov 2003 22:42:16 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Catalin BOIE <util@deuroconsult.ro>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 + 2 * P IV Xeon 2.4GHz with HT + SATA + RAID1 = scheduler
 problems
References: <Pine.LNX.4.58.0311131303500.4183@hosting.rdsbv.ro>
In-Reply-To: <Pine.LNX.4.58.0311131303500.4183@hosting.rdsbv.ro>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Catalin BOIE wrote:

>Hi!
>
>I want to tell you that 2.6.0-test gets better and better. It works very
>very well on several systems. Thank you very much, guys.
>
>I have an server (like in the subject). The problem is that the scheduler
>seems to behave weird. Sometimes a program just do nothing. There is no
>disk activity, interrupts are a little over 1000, no disk requests,
>context switches are ~40. The system is idle but it has work to do!
>Can I provide more info?
>
>I tried to put elevator=deadline and things seems worse.
>
>If I'm not mistaken, the processes are in D state. Bt I'm not sure, I must
>check again and right now I can't.
>

Hi,
Please capture a Ctrl + Scroll Lock dump when you get processes stuck in
D state.

>
>Also I suspect that scheduler doesn't pay special attention to virtual
>(HT) processors. Is this true?
>

This is correct. Are you seeing any problems with HT? I think Linus
was hoping the NUMA / SMP scheduler could be generalised a bit more
so that HT would just fall into place. This might not happen before
2.7, so the shared runqueue approach might be the next best thing
(I like it).


