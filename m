Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277008AbRJKWlW>; Thu, 11 Oct 2001 18:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277022AbRJKWlM>; Thu, 11 Oct 2001 18:41:12 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:49164 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277008AbRJKWlG>; Thu, 11 Oct 2001 18:41:06 -0400
Date: Thu, 11 Oct 2001 18:41:32 -0400
Message-Id: <200110112241.f9BMfWM27107@deathstar.prodigy.com>
To: jdthood@mail.com
Subject: Re: [PATCH] 2.4.10-ac11 parport_pc.c bugfix
X-Newsgroups: linux.dev.kernel
In-Reply-To: <1002808349.10317.7.camel@thanatos>
Organization: TMR Associates, Schenectady NY
Cc: linux-kernel@vger.kernel.org
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1002808349.10317.7.camel@thanatos> you write:
| I guess the question is: Which way is more portable?  Is
| "(unsigned long)-1" liable to turn out as something other than
| ~0U?
| 
| If your way of expressing it is more portable then we should
| make the change ... BOTH in pnp_bios.c and in parport_pc.c .
| 
| Opinions?

Does this address any bug present without the cast? If the expression
left of == is unsigned long, ~0U will work, as will (unsigned)~0. But
more to the point, do you mean "minus one" or "all ones" here? While
Linux does not currently run on any machine which is not 2's complement,
I think if you want all ones you should use (unsigned long)~0 as most
portable.

Yes, I have programmed 1's complement machines :-(

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
