Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUEODmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUEODmd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 23:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264642AbUEODmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 23:42:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:52618 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262434AbUEODmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 23:42:32 -0400
Date: Fri, 14 May 2004 20:41:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lincoln Dale <ltd@cisco.com>
Cc: adi@bitmover.com, elenstev@mesatop.com, scole@lanl.gov,
       support@bitmover.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
Message-Id: <20040514204153.0d747933.akpm@osdl.org>
In-Reply-To: <5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14>
References: <200405132232.01484.elenstev@mesatop.com>
	<20040514144617.GE20197@work.bitmover.com>
	<200405131723.15752.elenstev@mesatop.com>
	<200405122234.06902.elenstev@mesatop.com>
	<15594C37-A509-11D8-A7EA-000A95CC3A8A@lanl.gov>
	<20040513183316.GE17965@bitmover.com>
	<200405131723.15752.elenstev@mesatop.com>
	<6616858C-A5AF-11D8-A7EA-000A95CC3A8A@lanl.gov>
	<20040514144617.GE20197@work.bitmover.com>
	<200405122234.06902.elenstev@mesatop.com>
	<15594C37-A509-11D8-A7EA-000A95CC3A8A@lanl.gov>
	<20040513183316.GE17965@bitmover.com>
	<200405131723.15752.elenstev@mesatop.com>
	<5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale <ltd@cisco.com> wrote:
>
> At 02:53 AM 15/05/2004, Andy Isaacson wrote:
> >That corruption size really does make me think of network packets, so
> >I'm tempted to blame it on PPP.  Can you find out the MTU of your PPP
> >link?  "ifconfig ppp0" or something like that.
> 
> 1352 bytes coule be remarkably close to the TCP MSS . . .
> perhaps there is some interaction with ppp where there is an overrun / lost 
> packet and the TCP window is mistakenly advanced?

Steve, if it's a memory stomp then perhaps CONFIG_DEBUG_PAGEALLOC and
CONFIG_DEBUG_SLAB might pick it up.

It seems awfully deterministic though.
