Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030531AbWBHFjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030531AbWBHFjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030532AbWBHFjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:39:20 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:16052 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1030531AbWBHFjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:39:19 -0500
From: Grant Coady <gcoady@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
Date: Wed, 08 Feb 2006 16:39:09 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <ql0ju1hesplkt6sto96viehbeck3uhkrdv@4ax.com>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com> <200602081335.18256.kernel@kolivas.org> <24niu1hrom6udfa2km18b8bagad62kjamc@4ax.com> <200602081400.59931.kernel@kolivas.org> <nutiu1dkoldca31ddusfbd2rv41q7q0k3m@4ax.com> <20060208051709.GE11380@w.ods.org>
In-Reply-To: <20060208051709.GE11380@w.ods.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,
On Wed, 8 Feb 2006 06:17:09 +0100, Willy Tarreau <willy@w.ods.org> wrote:

>Hi Grant,
>
>On Wed, Feb 08, 2006 at 03:51:24PM +1100, Grant Coady wrote:
>> On Wed, 8 Feb 2006 14:00:59 +1100, Con Kolivas <kernel@kolivas.org> wrote:
>> 
>> >This is the terminal's fault. xterm et al use an algorithm to determine how 
>> >fast your machine is and decide whether to jump scroll or smooth scroll. This 
>> >algorithm is basically broken with the 2.6 scheduler and it decides to mostly 
>> >smooth scroll.
>> 
>> Strange it does that over localnet to a PuTTY terminal on windoze.
>> 
>> Seems a strange thing to do in the kernel though, presentation 
>> buffering / management surely can be done in userspace?
>
>I suspect the sshd on the firewall gets woken up for each line and it
>behaves exactly like an xterm. After having done a lot of "ls -l|cat"
>on 2.6, I'm not surprized at all :-/
>
>A good test would be to strace sshd under 2.4 and 2.6. You could even
>use strace -tt. Probably that you will see something like 1 ms between
>two reads on 2.6 and nearly nothing between them in 2.4.

Yes, it is nearly 1ms per line delay with 2.6, but 2.4 and 2.6 with the 
trailing '|cat' give similar times, didn't try that notion last time.  

We know now it isn't the network cards, disk I/O, just an oddness in 2.6 ;)

Cheers,
Grant.
