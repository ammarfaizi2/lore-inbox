Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbTITBlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 21:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTITBlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 21:41:23 -0400
Received: from dyn-ctb-210-9-246-80.webone.com.au ([210.9.246.80]:35589 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261251AbTITBlW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 21:41:22 -0400
Message-ID: <3F6BB01A.7060506@cyberone.com.au>
Date: Sat, 20 Sep 2003 11:40:42 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: root@chaos.analogic.com, William Lee Irwin III <wli@holomorphy.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG at mm/memory.c:1501 in 2.6.0-test5
References: <95932E0ADB@vcnet.vc.cvut.cz> <Pine.LNX.4.53.0309190838440.14130@chaos>
In-Reply-To: <Pine.LNX.4.53.0309190838440.14130@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:

>On Thu, 18 Sep 2003, Petr Vandrovec wrote:
>
>
>>On 18 Sep 03 at 13:43, William Lee Irwin III wrote:
>>
>>>On Thu, Sep 18, 2003 at 10:27:58PM +0200, Petr Vandrovec wrote:
>>>
>>>>EIP:    0060:[<c015be10>]    Tainted: PF
>>>>
>>>                snprintf(buf, sizeof(buf), "Tainted: %c%c%c",
>>>                        tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
>>>                        tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
>>>                        tainted & TAINT_UNSAFE_SMP ? 'S' : ' ');
>>>
>>>This is probably the reason you're not getting much in the way of a
>>>response.
>>>
>>I explicitly stated that it happened shortly after I shut down VMware UI,
>>and that I spent whole day trying to find what's going on, finally
>>politely asking for help, hoping that someone could have a clue
>>what went wrong.
>>                                            Petr Vandrovec
>>
>>
>
>Okay. I'll be more specific. The "Tainted PF" shown above is
>because you have installed a module that is [P]roprietary and
>it was [F]orced to load.
>
>Any module running inside the kernel can destroy anything.
>There is no protection inside the kernel. A simple bug in any
>module can not only cause your machine to die, but it can, in
>principle, destroy everything on your hard disk as well as
>shutting down your LAN, causing millions of dollars of
>damages (seriously). It is possible.
>
>Therefore, If you report a bug, and your system is tainted
>with a proprietary module, nobody can help you because the
>

You should send your report to the vendor. They might not be supporting
2.6 yet though. Alternatively, try to reproduce the problem having never
loaded closed source modules since booting: it is now much less
frustrating for developers to track down and fix.



