Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbUB2W4p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 17:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbUB2W4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 17:56:45 -0500
Received: from alt.aurema.com ([203.217.18.57]:60076 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262172AbUB2W4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 17:56:43 -0500
Message-ID: <40426E1C.8010806@aurema.com>
Date: Mon, 01 Mar 2004 09:56:28 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joachim B Haga <c.j.b.haga@fys.uio.no>
CC: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.fi4j08o.17nchps@ifi.uio.no> <fa.ctat17m.8mqa3c@ifi.uio.no> <yydjishqw10p.fsf@galizur.uio.no>
In-Reply-To: <yydjishqw10p.fsf@galizur.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joachim B Haga wrote:
> Peter Williams <peterw@aurema.com> writes:
> 
> 
>>>>They already do e.g. renice is such a program.
>>>
>>>No one's talking about LOWERING priority here.  You can only DoS
>>>someone else if you can set negative nice values, and non-root
>>>can't do that.
>>
>>Which is why root has to be in control of the mechanism.
> 
> 
> It seems to me that much of this could be solved if the user *were*
> allowed to lower nice values (down to 0).
> 
> Right now the only way I can prioritize between my own processes by
> starting important/timing sensitive programs normally and everything
> else reniced. The problem is that the first category consists of one
> or two programs while the second category is, well, "everything else".
> 
> I would *love* to be able to start the window manager and all children
> at +10 and be able to adjust priorities, from 0 (important user-level)
> to 10 (normal) to 20. Negative values could still be root-only.
> 
> So why shouldn't this be possible? Because a greedy user in a
> multi-user system would just run everything at max prio thus defeating
> the purpose? Sure, that would be annoying but it would have another
> solution ie. an entitlement based scheduler or something.

More importantly it would allow ordinary users to override root's 
settings e.g. if (for whatever reason) the sysadmin decided to renice a 
task to 19 (say) this modification would allow the owner of the task to 
renice it back to zero.  This is the reason that it isn't be allowed.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

