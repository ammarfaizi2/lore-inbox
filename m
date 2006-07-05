Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWGEHbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWGEHbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 03:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWGEHbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 03:31:12 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:55256 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932189AbWGEHbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 03:31:11 -0400
Message-ID: <44AB6AB3.5070407@sgi.com>
Date: Wed, 05 Jul 2006 09:30:59 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, Keith Owens <kaos@sgi.com>,
       torvalds@osdl.org, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net>	<21169.1151991139@kao2.melbourne.sgi.com> <20060703234134.786944f1.akpm@osdl.org> <44AAA64D.8030907@yahoo.com.au>
In-Reply-To: <44AAA64D.8030907@yahoo.com.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Andrew Morton wrote:
>> I expect raw_smp_processor_id() is used here as a a microoptimisation -
>> avoid a might_sleep() which obviously will never trigger.
> 
> A microoptimisation because they've turned on DEBUG_PREEMPT and found
> that smp_processor_id slows down? ;) Wouldn't it be better to just stick
> to the normal rules (ie. what Keith said)?
> 
> It may be obvious in this case (though that doesn't help people who make
> obvious mistakes, or mismerge patches) but this just seems like a nasty
> precedent to set (or has it already been?).

I suspect the real reason here is that there's now so many ways to get
the processor ID that I cannot keep track of which one to use. Paul's
mention of __raw_get_cpu_var() just confuses me even more.

So if anyone can give me a conclusive answer of which one to use, I'm
happy to go there.

Granted I have a bias to avoid anything involving the preempt crap, but
thats just me :)

Cheers,
Jes
