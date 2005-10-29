Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVJ2AhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVJ2AhW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVJ2AhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:37:22 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:4789 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750945AbVJ2AhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:37:21 -0400
Subject: Re: kernel-2.6.14-rc5-rt7 - 604.62 BogoMIPS (2.6.14-rc5 - 6024.43
	BogoMIPS) problem with bogometer ?
From: Steven Rostedt <rostedt@goodmis.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu
In-Reply-To: <1130544632.6169.63.camel@localhost.localdomain>
References: <200510281828.AA38666812@usfltd.com>
	 <1130542935.27168.431.camel@cog.beaverton.ibm.com>
	 <1130544632.6169.63.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 28 Oct 2005 20:37:01 -0400
Message-Id: <1130546221.6169.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > That should explain a differing lpj value, although 10x smaller is a
> > little strange, so I'll dig into this on my system and see if I find
> > anything.
> > 
> > Do let me know if you see any actual changes in behavior (drivers acting
> > funny, etc).
> 
> John, 
> 
> Don't waste any time on this.  This was caused by a brain fart on
> Thomas' part :-)  Some legacy code in ktimer_interrupt returned a enum
> that was being used to update the ticks.  So before high-res was
> activated, the jiffies would be incremented 7 times instead of just
> once.  It's already been fixed. Just waiting for Ingo to release his new
> patch.

John,

Would you want to be CC'd on all ktimer related patches?  This way you
wont think things like this was caused by your code.

-- Steve


