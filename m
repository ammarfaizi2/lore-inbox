Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbULNAwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbULNAwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 19:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbULNAwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 19:52:04 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:4769 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261363AbULNAvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 19:51:51 -0500
Message-ID: <41BE3920.5020904@yahoo.com.au>
Date: Tue, 14 Dec 2004 11:51:44 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Mikhail Ramendik <mr@ramendik.ru>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
References: <200412121728.16968.mr@ramendik.ru>
In-Reply-To: <200412121728.16968.mr@ramendik.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikhail Ramendik wrote:
> Hello,
> 
> With kernel 2.6.10-rc3 and 256 M RAM, when I start a task taht eats a ot of 
> RAM (for example, viewing a big TIFF file; also tested with a synthetic 
> "eater"), in the resulting swapping process kswapd tahes quite a bit of CPU 
> time. The computer becomes extremely unresponsive, the clock (in icewm) stops 
> for periods of time up to a minute). And the task startup itself is somewhaat 
> slow.
> 
> I have checked both 2.6.8.1 and 2.6.9 for comparison, and they fare a lot 
> better. The CPU hogging is not there, the computer is much more responsive, 
> and the task starts faster.
> 

Hi Mikhail,

I'm not quite sure what the problem would be. Please check that you are using
the same config for each kernel, and both kernels have detected the same amount
of memory.

Then, can you start by posting /proc/vmstat before and after running the
synthetic "eater" for some amount of time, with both 2.6.9 and 2.6.10-rc3; so:

boot 2.6.9
cat /proc/vmstat > 2.6.9-pre ; ./eater ; cat /proc/vmstat 2.6.9-post

and the same for 2.6.10-rc3.

Also, /proc/meminfo and /proc/slabinfo output for each kernel before running
eater may give some clues.

Oh, and can you post the source code for the "eater" as well, please?

Thanks,
Nick
