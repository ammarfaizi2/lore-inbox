Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbUCLMsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 07:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbUCLMsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 07:48:51 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:44762 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262077AbUCLMss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 07:48:48 -0500
Message-ID: <4051B0C6.2070302@cyberone.com.au>
Date: Fri, 12 Mar 2004 23:44:54 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Urlichs <smurf@smurf.noris.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
References: <404FACF4.3030601@cyberone.com.au> <200403111825.22674@WOLK> <40517E47.3010909@cyberone.com.au> <20040312012703.69f2bb9b.akpm@osdl.org> <pan.2004.03.12.11.08.02.700169@smurf.noris.de>
In-Reply-To: <pan.2004.03.12.11.08.02.700169@smurf.noris.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matthias Urlichs wrote:

>Hi, Andrew Morton wrote:
>
>
>>That effect is to cause the whole world to be swapped out when people
>>return to their machines in the morning.
>>
>
>The correct solution to this problem is "suspend-to-disk" --
>if the machine isn't doing anything anyway, TURN IT OFF.
>
>

Without arguing that point, the VM also should have a solution
to the problem where people don't turn it off.

>One slightly more practical solution from the "you-now-who gets angry
>mails" POV anyway, would be to tie the reduced-rate scanning to the load
>average -- if nothing at all happens, swap-out doesn't need to happen
>either.
>
>

Well if nothing at all happens we don't swap out, but when something
is happening, desktop users don't want any of their programs to be
swapped out no matter how long they have been sitting idle. They don't
want to wait 10 seconds to page something in even if it means they're
waiting an extra 10 minutes throughout the day for their kernel greps
and diffs to finish.

