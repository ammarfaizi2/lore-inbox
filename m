Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292599AbSCNL1G>; Thu, 14 Mar 2002 06:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311586AbSCNL04>; Thu, 14 Mar 2002 06:26:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39691 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292599AbSCNL0x>;
	Thu, 14 Mar 2002 06:26:53 -0500
Message-ID: <3C9088F0.8090602@mandrakesoft.com>
Date: Thu, 14 Mar 2002 06:26:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com, rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
In-Reply-To: <E16lTC9-0003uL-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

>In message <3C902FA5.5010208@mandrakesoft.com> you write:
>
>>Your other changes look good, but RELOC_HIDE really does belong in 
>>compiler.h... and percpu.h is a particularly poor choice of destination. 
>>
>
>How?  compiler.h is for things which vary based on compiler versions.
>

The name "linux/compiler.h" does not imply that to me, nor do the 
comments in the file, which are related specifically to __ builtin_expect.

RELOC_HIDE is a potentially general facility (with the caveat below), 
that does not seem to directly relate to the name "linux/percpu.h" at 
all, except by happenstance due to its origins.  Subjectively it seemed 
to me that compiler.h was the most appropriate.  Maybe kernel.h is a 
better choice, in others' eyes.  But I think percpu.h is probably the 
wrong home.

>
>It was an arbitrary and relatively crappy place to put it: I only put
>it there so PPC could use it...
>
Will other arches -ever- use the macro?  If not, include/asm-ppc is a 
better place...

    Jeff "mountain out of a molehill" Garzik



