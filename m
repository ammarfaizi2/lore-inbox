Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUBYVTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbUBYVSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:18:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:9974 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261554AbUBYVRZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:17:25 -0500
Message-ID: <403D10DB.8060506@mvista.com>
Date: Wed, 25 Feb 2004 13:17:15 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: [Kgdb-bugreport] Re: kgdb: rename i386-stub.c to kgdb.c
References: <20040224130650.GA9012@elf.ucw.cz> <200402251303.50102.amitkale@emsyssoft.com> <20040225103703.GB6206@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040225103703.GB6206@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>kgdb uses really confusing names for arch-dependend parts. This fixes
>>>it. Okay to commit?
>>
>>Why is arch/$x/kernel/$x-stub.c confusing? The name $x-stub.c is indicative of 
>>architecture dependent code in it. Err, well so is the path.
> 
> 
> 
> Well, looking at i386-stub.c, how do you know it is kgdb-related?
> 
> 
>>PPC and sparc stubs in present vanilla kernel use this naming convention. 
>>That's why I adopted it.
>>
>>I find kernel/kgdbstub.c, arch/$x/kernel/$x-stub.c more consistent compared to 
>>kernel/kgdbstub.c, arch/$x/kernel/kgdb.c
> 
> 
> I actually made it kernel/kgdb.c and arch/*/kernel/kgdb.c. I believe
> there's no point where one could be confused....

gdb itself gets confused with this.  Try, for example, time.c which, on the x86, 
is in both arch and common code.  I use emacs with kgdb and it gets confused 
when I point at a location in the source and tell it to set a break point.

Please, lets have only one of each name.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

