Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTHTQmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 12:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTHTQmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 12:42:15 -0400
Received: from dyn-ctb-210-9-246-224.webone.com.au ([210.9.246.224]:33796 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262050AbTHTQmL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 12:42:11 -0400
Message-ID: <3F43A4D9.7040305@cyberone.com.au>
Date: Thu, 21 Aug 2003 02:42:01 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Wiktor Wodecki <wodecki@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O17int
References: <200308200102.04155.kernel@kolivas.org> <20030820162736.GA711@gmx.de>
In-Reply-To: <20030820162736.GA711@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Wiktor Wodecki wrote:

>On Wed, Aug 20, 2003 at 01:01:28AM +1000, Con Kolivas wrote:
>
>>Food for the starving masses.
>>
>snip
>
>Sorry, but I still have the starving problem. the more I use O16/O17 the
>more problems I encounter. xterms sometimes wake up after half a second
>for another half a second and falls asleep for a whole second then.
>after that, it's fully interactive. io-load seems to produce the
>problem. a simple tar xf linux-2.6.0-test3.tar seems to halt the system.
>new processes take ages to start. This also happend to me on O16.2.
>Maybe it's because some AS patches are missing in vanilla but are in
>2.6.0-test3-mm?
>

There are no AS patches missing in vanilla. I don't think there are..
none that would change that.

Its unlikely that its an IO problem because its unlikely that your tar
would be evicting anything that X or the xterm depend on. If the
machine is swapping at this time then try setting /proc/sys/vm/swappiness
to 0.

Oh, you could try my cpu scheduler patch a try if you're bored.


