Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265035AbUD2XEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265035AbUD2XEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 19:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUD2XEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 19:04:42 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:63756 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265035AbUD2XD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 19:03:27 -0400
Message-ID: <40918AD2.9060602@techsource.com>
Date: Thu, 29 Apr 2004 19:08:02 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       akpm@osdl.org, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <40904A84.2030307@yahoo.com.au>	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>	<20040429133613.791f9f9b.pj@sgi.com>	<409175CF.9040608@techsource.com>	<20040429144737.3b0c736b.pj@sgi.com>	<40917F1E.8040106@techsource.com> <20040429154632.4ca07cf9.pj@sgi.com>
In-Reply-To: <20040429154632.4ca07cf9.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Paul Jackson wrote:

> 
> In other words, I wouldn't agree with your take that it's a matter of
> not trusting the application, better to GUESS.  

Okay.

> Rather I would say that
> there is a preference, and a good one at that, to not use an excessive
> number of knobs as a cop-out to avoid working hard to get the widest
> practical range of cases to behave reasonably, without intervention, and
> a preference to keep what knobs that are there short, sweet and
> minimally interacting.
> 

Agreed.  And this is why I suggested not adding another knob but rather 
going with the existing nice value.

Mind you, this shouldn't necessarily be done without some kind of 
experimentation.  Put two knobs in the kernel and try varying them  to 
each other to see what sorts of jobs, if any, would benefit in a 
disparity between cpu-nice and io-nice.  If there IS a significant 
difference, then add the extra knob.  If there isn't, then don't.

Another possibility would be to have one knob that controls cpu-nice, 
and another knob that controls io-nice minus cpu-nice, so if you REALLY 
want to make them different, you can, but typically, they are set to be 
the same.

