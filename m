Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSHLIYf>; Mon, 12 Aug 2002 04:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSHLIYf>; Mon, 12 Aug 2002 04:24:35 -0400
Received: from frigate.technologeek.org ([62.4.21.148]:16003 "EHLO
	frigate.technologeek.org") by vger.kernel.org with ESMTP
	id <S317541AbSHLIYe>; Mon, 12 Aug 2002 04:24:34 -0400
To: Brad Hards <bhards@bigpond.net.au>
Cc: Adrian Bunk <bunk@fs.tum.de>, <greg@kroah.com>,
       linux-kernel@vger.kernel.org, rlievin@free.fr
Subject: Re: [2.5 patch] tiglusb.c must include version.h
References: <Pine.NEB.4.44.0208111416110.3636-100000@mimas.fachschaften.tu-muenchen.de>
	<200208121012.59099.bhards@bigpond.net.au>
From: Julien BLACHE <jb@jblache.org>
Date: Mon, 12 Aug 2002 10:28:18 +0200
In-Reply-To: <200208121012.59099.bhards@bigpond.net.au> (Brad Hards's
 message of "Mon, 12 Aug 2002 10:12:47 +1000")
Message-ID: <87znvsmqfx.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) XEmacs/21.4 (Honest Recruiter,
 powerpc-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Hards <bhards@bigpond.net.au> wrote:

Hi,

>> line 44 is:
>>   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
>>
>>
>> The fix is simple:
> <snip>
>> +#include <linux/version.h>
>
> Wouldn't it be cleaner to just remove this case? It is in 2.5, after all.

We use this case so we don't have to maintain 2 /slightly/ different
versions of the source, as we're distributing this module outside of
the kernel tree for use with kernel 2.4.x.

Moreover I asked Greg to push this module into the 2.4 tree if
possible, so as long as there aren't major changes in the 2.5 code
I'd really like to keep the same source for 2.4 and 2.5.

But if this should become a hassle for anybody, I'll remove this case
ASAP.

JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org> 
