Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTJXSGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 14:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTJXSGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 14:06:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:42964 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262434AbTJXSF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 14:05:59 -0400
Subject: Re: Re: 2.6.0-test8 mad clock rate drifts and sleeping function ...
From: john stultz <johnstul@us.ibm.com>
To: Roland Lezuo <roland.lezuo@chello.at>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200310241306.57433.roland.lezuo@chello.at>
References: <200310231044.46668.roland.lezuo@chello.at>
	 <1066938672.1119.85.camel@cog.beaverton.ibm.com>
	 <200310241306.57433.roland.lezuo@chello.at>
Content-Type: text/plain
Organization: 
Message-Id: <1067018643.1118.199.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Oct 2003 11:04:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-24 at 04:06, Roland Lezuo wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> > So you're seeing time run twice as fast overall? Are you running with
> > NTP?  Do you have any sort of hardware power management on the system?
> > Do you have any more details about the system?
> 
> I used to run NTP but I thought I didn't do that when I epxerienced that clock 
> drift. The Box (after a restart) is up for 1 day and 13 hours now, there is 
> no clock drift any more...
> ...the xmms problem disappeared by recompileing the xmms-alsa plugin (which is 
> strange for me), but it is gone...
> 
> 
> the only thing left:
> 
> Debug: sleeping function called from invalid context at 
> include/asm/uaccess.h:473
> in_atomic():0, irqs_disabled():1
> Call Trace:
>  [<c0120150>] __might_sleep+0xa0/0xd0
>  [<c010d40a>] save_v86_state+0x6a/0x200
>  [<c010ca67>] do_IRQ+0x117/0x160
>  [<c010a49e>] work_notifysig_v86+0x6/0x14
>  [<c010a44b>] syscall_call+0x7/0xb
> 
> ... there are more of this called from different source files...

Dunno about that one, but please let me know if you later find you can
reproduce the time drift issue. 

thanks
-john


