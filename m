Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbULZCpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbULZCpe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 21:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbULZCpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 21:45:34 -0500
Received: from mail.tmr.com ([216.238.38.203]:8644 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261601AbULZCp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 21:45:28 -0500
Message-ID: <41CE282C.3010606@tmr.com>
Date: Sat, 25 Dec 2004 21:55:40 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ho ho ho - Linux v2.6.10
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, with a lot of people taking an xmas break, here's something to play
> with over the holidays (not to mention an excuse for me to get into the
> Glögg for real ;)
> 
> Mostly a lot of small fixes since 2.6.10-rc3, with the biggest thing being
> probably the CIFS update and the switch-over to the new DVB frontend
> driver world order.  Some MMC and USB work too, and ARM updates as usual.

Alas, It sort-of boots but is terminally slow. I see the log with 
endless repetitions of "irq 18 nobody cared" and some trace, then 
"disabling irq 18." Unfortunately it lies, after about 20MB of this I 
decided it had no real intention of disabling irq 18 and tried to stop 
it. After ten minutes I had to pull the plug and it's still cleaning 
filesystems.

I will dig through the log after it gets back up, but there is clearly a 
problem in the logic to ignore garbage irq's, or at least stop whining. 
If there is any similarity between the traces I'll post, but I suspect 
that it was one of those edge vs. level things by the behaviour.

Just a warning in case others are seeing a failure of irq disable to 
actually work.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
