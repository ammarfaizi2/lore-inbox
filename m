Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272041AbTG2TGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272043AbTG2TGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:06:19 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:35560 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272041AbTG2TGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:06:11 -0400
Subject: Re: [BUG] 2.6.0-test2 loses time on 486
From: john stultz <johnstul@us.ibm.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200307291734.h6THYhmp012585@harpo.it.uu.se>
References: <200307291734.h6THYhmp012585@harpo.it.uu.se>
Content-Type: text/plain
Organization: 
Message-Id: <1059505144.14761.55.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 Jul 2003 11:59:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-29 at 10:34, Mikael Pettersson wrote:
> My old 486 test box is losing time at an alarming rate
> when running 2.6.0-test kernels. It loses almost 2 minutes
> per hour, less if it sits idle. This problem does not
> occur when it's running a 2.4 kernel.
> 
> There's nothing noteworthy in dmesg.
> 
> This has been going on since at least the 2.5.7x kernels,
> and possible also the 2.5.6x kernels. I strongly suspect
> a bug in the time-keeping changes in late 2.5 kernels.
> The 486 has no TSC, and I don't have an NTP server to
> keep my machines' times in sync.

Hmm.  Sounds like you're loosing interrupts. This can happen due to
poorly behaving drivers (disabling interrupts for too long), or odd
hardware. The change from HZ=100 to HZ=1000 probably made this more
visible on your box, so could you try setting HZ back to 100 and see if
that helps (you may still lose time, but at a much slower rate). 

Also what drivers are you running with?

thanks
-john


