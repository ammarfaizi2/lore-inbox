Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVDMDbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVDMDbg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVDMD1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 23:27:30 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:14239 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262595AbVDMD0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 23:26:47 -0400
Message-ID: <425C914A.3070604@yahoo.com.au>
Date: Wed, 13 Apr 2005 13:26:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>,
       tony.luck@intel.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: unlocked context-switches
References: <3R6Ir-89Y-23@gated-at.bofh.it>	<ugoecowjci.fsf@panda.mostang.com>	<20050409070738.GA5444@elte.hu>	<16983.33049.962002.335198@napali.hpl.hp.com>	<20050409155810.593d8f7b.davem@davemloft.net>	<20050410064324.GA24596@elte.hu>	<16987.7956.806699.617633@napali.hpl.hp.com>	<1113271965.5090.24.camel@npiggin-nld.site> <16988.477.530205.502023@napali.hpl.hp.com>
In-Reply-To: <16988.477.530205.502023@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
>>>>>>On Tue, 12 Apr 2005 12:12:45 +1000, Nick Piggin <nickpiggin@yahoo.com.au> said:
> 
> 
>   >> Now, Ingo says that the order is reversed with his patch, i.e.,
>   >> switch_mm() happens after switch_to().  That means flush_tlb_mm()
>   >> may now see a current->active_mm which hasn't really been
>   >> activated yet.
> 
>   Nick> If that did bother you, could you keep track of the actually
>   Nick> activated mm in your arch code? Or would that involve more
>   Nick> arch hooks and general ugliness in the scheduler?
> 
> I'm sorry, but I don't see the point of this.  We are already tracking
> care of ownership, just not atomically.  What's the point of putting
> another level of (atomic) tracking on top of it.  That seems
> exceedingly ugly.
> 

Well, you were worried about it not being atomic. So that would be
the point, but I agree it would probably be exceedingly ugly if
implemented.

Nick

