Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbWECIND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWECIND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 04:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWECINC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 04:13:02 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:16650 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965059AbWECINA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 04:13:00 -0400
Message-ID: <445865F7.1010208@shadowen.org>
Date: Wed, 03 May 2006 09:12:39 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jan Beulich <jbeulich@novell.com>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com> <200605030849.44893.ak@suse.de> <4458730F.76E4.0078.0@novell.com> <200605030938.37967.ak@suse.de>
In-Reply-To: <200605030938.37967.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 03 May 2006 09:08, Jan Beulich wrote:
> 
>>>>><EOE>new stack 0 (0 0 0 10082 10)
>>>>
>>>>Looks like <rubbish> <SS> <RSP> <RFLAGS> <CS> to me, ...
>>>
>>>Hmm, right.
>>>
>>>
>>>>>Hmm weird. There isn't anything resembling an exception frame at the top of the
>>>>>stack.  No idea how this could happen.
>>>>
>>>>... which is a valid frame where the stack pointer was corrupted before the exception occurred. One more printed
>>
>>item
>>
>>>>(or rather, starting items at estack_end[-1]) would allow at least seeing what RIP this came from.
>>>
>>>Any can you add that please and check? 
>>
>>???
> 
> 
> Sorry I meant to write Andy but left out the d :-( - he did the testing
> on the machine that showed the problem.

Heh, happy to do the testing.  Just to make sure I am doing the right
thing, you want an entire stack frame dropped out in the case that
SS/RSP are 0; so we get the RIP.

-apw
