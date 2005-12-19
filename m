Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVLSQXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVLSQXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVLSQXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:23:03 -0500
Received: from sccrmhc13.comcast.net ([63.240.77.83]:28657 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964820AbVLSQXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:23:01 -0500
In-Reply-To: <43A694DF.8040209@aitel.hist.no>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218054323.GF23384@wotan.suse.de> <5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net> <43A694DF.8040209@aitel.hist.no>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A3567036-A5F9-4CF9-BC48-70CFEAA8F2C4@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Mon, 19 Dec 2005 11:22:48 -0500
To: Helge Hafting <helge.hafting@aitel.hist.no>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 19, 2005, at 6:09 AM, Helge Hafting wrote:

> I suggest a little experiment for you.  Make a kernel module which  
> do nothing
> except try to allocate 16k of _contigous_ kernel memory, and
> printk whether it succeeded or failed before exiting.  Have cron  
> run that
> every 5 minutes.  After a few weeks of running this low-impact test on
> a busy loaded server, look at statistics about how often the 16k  
> allocation
> worked - and how often it failed.

I am aware of the limitations of Linux MM and the problems associated  
with anything more than zero order allocations over a period of time.

My argument was it's not that a ton of i386 users are affected by  
having choice of stack sizes (I read LKML quite frequently and for  
long I don't remember seeing allocation failure errors - either  
people moved to 64  bits without LOWMEM and that helped or people  
just do fine with the current 8K stack on i386) and even if some are,  
let's leave the stack size as an option - it's not like it cause a  
lot of code bloat or other problems (I read your argument about VM  
developers bogged down by having to deal with 8K stacks but quite  
frankly I don't understand how.)

Whoever benefits can use the 4K stacks, others who feel it risky to  
have 4K stacks for whatever reason, can be happy too. We can even  
make the 4K default, but having supported option of 8K is important  
and almost all operating systems are having >4K stacks on i386  
machines, so there is some reason for having it.

But I rest my argument, I no longer use i386 and I am being told this  
patch only affects i386! ;)

Parag
