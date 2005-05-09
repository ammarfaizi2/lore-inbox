Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVEITWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVEITWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 15:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVEITWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 15:22:45 -0400
Received: from mail.tmr.com ([64.65.253.246]:51211 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261485AbVEITWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 15:22:37 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: /proc/cpuinfo format - arch dependent!
Date: Mon, 09 May 2005 14:14:14 -0400
Organization: TMR Associates, Inc
Message-ID: <427FA876.7000401@tmr.com>
References: <20050507172005.GB26088@redhat.com><20050507172005.GB26088@redhat.com> <20050508012521.GA24268@SDF.LONESTAR.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1115666539 7980 192.168.12.100 (9 May 2005 19:22:19 GMT)
X-Complaints-To: abuse@tmr.com
Cc: Dave Jones <davej@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
To: Jim Nance <jlnance@sdf.lonestar.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
In-Reply-To: <20050508012521.GA24268@SDF.LONESTAR.ORG>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Nance wrote:
> On Sat, May 07, 2005 at 01:20:05PM -0400, Dave Jones wrote:
> 
>>On Sat, May 07, 2005 at 07:05:56PM +0200, Willy Tarreau wrote:
> 
> 
>> > system "hey, I'd like this type of workload, how many process should
>> > I start, and where should I bind them ?".
>>
>>I think generalising this and having a method to do this in the kernel
>>is a much better idea than each application parsing this themselves.
>>Things are only getting more and more complex as time goes on,
>>and I don't trust application developers to get it right.
> 
> 
> As a developer of a multiprocess/multithreaded application I can assure
> you that you are right not to trust application developers to get this
> right.  The idea that a programmer understands the behavior of the
> applications they write is largely a myth.  Furthermore, I suspect
> that SMT will evolve in directions that make the idea of a processor
> more and more fuzzy.  I don't think it is wise to construct any
> interface that suggests knowing the hardware details is good, or that
> processes should be bound by userland.  Certainly it is sometimes
> necessary for userland to do this, but we should look at that as a
> bug in the kernel.

Might I suggest that if you like the "we know best just trust us" 
approach, there is another OS to use. Making information available to 
good applications will improve system performance, or at least allow 
better limitation of requests for resources, and bad applications will 
be bad regardless of what you hide. You don't hide the CPU hardware any 
more than the memory size.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
