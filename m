Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTJYBOs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 21:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTJYBOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 21:14:48 -0400
Received: from mail-01.iinet.net.au ([203.59.3.33]:30111 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262221AbTJYBOr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 21:14:47 -0400
Message-ID: <3F99CEC3.10902@cyberone.com.au>
Date: Sat, 25 Oct 2003 11:15:47 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olien <dmo@osdl.org>
CC: kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] linux 2.6.0-test8 reaim tests fail to exit
References: <20031024220821.GA15231@osdl.org>
In-Reply-To: <20031024220821.GA15231@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Olien wrote:

>I've observed in the last two days, linux 2.6.0-test8 and I think
>linux 2.6.0-test8-mm1.  The reaim test workload fails to exit.
>All of the reaim tasks are blocked in sys_wait4().  But non of
>them seem to have any obvious child processes.
>
>There are also lots of sync() processes.  Many of those seem to be
>blocked somewhere scheduling IO.  These kernels were all with the
>as-isoched IO scheduler.  I may retry with deadline scheduler, just
>to rule out IO scheduler. Is there any link between the sync()
>processes and the reaim waiting for children?
>
>Could there be a problem with IO not completing for the sync()
>tasks that causes the reaim tasks to not complete?
>
>Attached is a console output from a system hung in this state.
>Included (towards the bottom) is a sysrq t output.
>
>I'm hoping to investigate this more closely over the week end.
>

Looks like IO scheduler. Testing deadline would be good. Thanks.

