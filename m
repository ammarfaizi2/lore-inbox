Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbUCCBE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 20:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbUCCBE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 20:04:59 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:63735 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262313AbUCCBE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 20:04:56 -0500
Message-ID: <40452F33.1060203@mvista.com>
Date: Tue, 02 Mar 2004 17:04:51 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Pavel Machek <pavel@ucw.cz>, "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kgdb: fix kgdbeth compilation and make it init late enough
References: <20040302112500.GA485@elf.ucw.cz> <20040302153250.GE16434@smtp.west.cox.net> <20040302222827.GD1225@elf.ucw.cz> <20040302224301.GK20227@smtp.west.cox.net>
In-Reply-To: <20040302224301.GK20227@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Tue, Mar 02, 2004 at 11:28:27PM +0100, Pavel Machek wrote:
> 
> 
>>Hi!
>>
>>
>>>>CONFIG_NO_KGDB_CPUS can not be found anywhere in the patches => its
>>>>probably not needd any more.
>>>
>>>I don't know if we can do that.  There's some funky locking stuff done
>>>on SMP, which for some reason can't be done to NR_CPUS (or, no one has
>>>tried doing that).
>>
>>There was no CONFIG_NO_KGDB_CPUS anywhere else in the CVS, that means
>>that test could not have been right.
> 
> 
> That doesn't mean the right answer is to remove it.  However, after
> talking with George (who might speak up now anyhow) for 2.6 we can just
> do the SMP locking stuff at NR_CPUS, since that's configurable.

The old CONFIG_NO_KGDB_CPUS only affected the kgdb_info array.  Its only purpose 
was to shorten the array as it I displayed it fairly often and having a bunch of 
unused stuff at the end was a bother.  Now that 2.6 lets you define this, it is 
no longer needed.

> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

