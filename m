Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280660AbRKBLq4>; Fri, 2 Nov 2001 06:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280658AbRKBLqr>; Fri, 2 Nov 2001 06:46:47 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:5508 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S280659AbRKBLqg>; Fri, 2 Nov 2001 06:46:36 -0500
Message-ID: <3BE28714.3070508@antefacto.com>
Date: Fri, 02 Nov 2001 11:44:20 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
In-Reply-To: <E15zF9H-0000NL-00@wagner> <3BE1271C.6CDF2738@mandrakesoft.com> <20011102124252.1032e9b2.rusty@rustcorp.com.au> <20011101185622.A20668@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:

> On Fri Nov 02, 2001 at 12:42:52PM +1100, Rusty Russell wrote:
> 
>>On Thu, 01 Nov 2001 05:42:36 -0500
>>Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>>
>>
>>>Is this designed to replace sysctl?
>>>
>>Well, I'd suggest replacing *all* the non-process stuff in /proc.  Yes.
>>
> 
> As I've thought about this in the past, I realized that /proc 
> is serving two purposes.  It is exporting the list of processes,
> and it is also used to export kernel and driver information.
> 
> What we really need is for procfs to be just process stuff, and the
> creation of a separate kernelfs nodev filesystem though which
> the kernel can share all the gory details about the hardware,
> drivers, phase of the moon, etc.   Since these serve two
> fundamentally different tasks, doesn't it make sense to split
> them into two separate filesystems?
> 
>  -Erik

Well the way I look @ it is that /proc should be the
only interface between kernel and user space, and therefore
a better name would be /kernel. I know this is not going
to happen because of all the userspace dependencies and
also probably too Plan9esque, but it's the right direction IMHO.

The process information you refer to is KERNEL data and
therefore "other" kernel data should not be split from the /proc
hierarchy. However as said above a better name would be
/kernel and it should be organised better.

Padraig.

