Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVKCAPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVKCAPi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVKCAPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:15:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:8940 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030218AbVKCAPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:15:37 -0500
Subject: Re: NTP broken with 2.6.14
From: john stultz <johnstul@us.ibm.com>
To: Jean-Christian de Rivaz <jc@eclis.ch>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43694DD1.3020908@eclis.ch>
References: <4369464B.6040707@eclis.ch>
	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>
	 <43694DD1.3020908@eclis.ch>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 02 Nov 2005 16:15:35 -0800
Message-Id: <1130976935.27168.512.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 00:37 +0100, Jean-Christian de Rivaz wrote:
> john stultz a écrit :
> > On Thu, 2005-11-03 at 00:05 +0100, Jean-Christian de Rivaz wrote:
> > 
> >>Since I have installed the new kernel 2.6.14, ntpd is unable to
> >>synchronize the time:
> > 
> > 
> > I'm working to see if I can reproduce this. Is this with 2.6.14 vanilla,
> > or from Linus' git tree post 2.6.14?
> 
> This is a vanilla 2.6.14 kernel from Linus git tree.
> The architecture is i386:
> Linux talla 2.6.14 #1 PREEMPT Tue Nov 1 17:27:04 CET 2005 i686 GNU/Linux

I can't seem to trivially reproduce this.


Your ntpq associations output looks suspicious, though. 
ind assID status  conf reach auth condition  last_event cnt
===========================================================
   1 14484  9014   yes   yes  none    reject   reachable  1

That reject condition seems odd.


What does running "ntpdate -uq <server>" produce?


Also, could you check 2.6.13, or even better do a binary search of
mainline releases since 2.6.8 to narrow down where this broke for you?


thanks
-john

