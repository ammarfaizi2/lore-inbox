Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTDPXMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 19:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTDPXMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 19:12:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57500 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261872AbTDPXMI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 19:12:08 -0400
Subject: Re: [PATCH] linux-2.5.67_lost-tick-fix_A2
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       James.Bottomley@SteelEye.com, shemminger@osdl.org, alex@ssi.bg
In-Reply-To: <3E9DE126.7040001@mvista.com>
References: <1050530545.1077.120.camel@w-jstultz2.beaverton.ibm.com>
	 <3E9DE126.7040001@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050535296.1077.204.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Apr 2003 16:21:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 16:03, george anzinger wrote:
> john stultz wrote: 
> > Some of the divs and mods being added here might concern folks, but by
> > not calling timer->get_offset() in detect_lost_tick() we eliminate much
> > of the same math. I did some simple cycle counting and the new code
> > comes out on average equivalent or faster. 
> 
> I think that if you look at the generated code you may find that there 
> are NO div in the asm code.  The C folks know about scaling to avoid 
> div especially when the divisor is a constant :)

Indeed you are correct. An objdump of both the timer_tsc.o and
timer_cyclone.o code reveals that the only divs occur in init code. I
like your argument better then mine :)

thanks
-john




