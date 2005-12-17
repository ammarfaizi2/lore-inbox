Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbVLQDvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVLQDvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 22:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVLQDvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 22:51:54 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:54690 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964922AbVLQDvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 22:51:54 -0500
Subject: Re: 2.6.15-rc5-rt2 slowness
From: Steven Rostedt <rostedt@goodmis.org>
To: john stultz <johnstul@us.ibm.com>
Cc: G.Ohrner@post.rwth-aachen.de, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1134773902.27117.14.camel@cog.beaverton.ibm.com>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134736325.13138.119.camel@localhost.localdomain>
	 <1134773902.27117.14.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 22:51:42 -0500
Message-Id: <1134791502.13138.164.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 14:58 -0800, john stultz wrote:
> On Fri, 2005-12-16 at 07:32 -0500, Steven Rostedt wrote:
> > I'll look into your oops later (or maybe Ingo has some time), but I've
> > also notice the slowness of 2.6.15-rc5-rt2, and I'm investigating it
> > now.
> 
> Hey Steven,
> 	Do check that the slowness you're seeing isn't related to the
> CONFIG_PARANIOD_GENERIC_TIME option being enabled. It is expected that
> the extra checks made by that config option would slow things down a
> bit.
> 

Hi John,

Thanks for the suggestion, but I've been running my tests with that
turned off.  Actually, I've turned off pretty much all debugging, and
added my own logdev device.  As mentioned in my previous email, that I
CC you on, I found the culprit.

Seems, the SLOB is not as fast as the SLAB. I'll look more into this
tomorrow. (My wife is taking by daughter out of town for gymnastics, so
I get to stay home and work :-/ )

-- Steve


