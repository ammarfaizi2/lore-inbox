Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268481AbUHLBHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268481AbUHLBHK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 21:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268418AbUHLAwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:52:33 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:36819 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268363AbUHLAu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:50:26 -0400
Date: Wed, 11 Aug 2004 20:54:21 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386 
In-Reply-To: <23701.1092268910@ocs3.ocs.com.au>
Message-ID: <Pine.LNX.4.58.0408112046200.2544@montezuma.fsmlabs.com>
References: <23701.1092268910@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, Keith Owens wrote:

> Tweak the profile code to detect that the instruction pointer is in the
> out of line spinlock code and replace the ip with the caller's ip.  We
> already do that for ia64, where the out of line spinlock code is a big
> win.  A kdb backtrace on an ia64 contended lock will even decode the
> address of the lock, which is only possible because the lock address is
> in a known location for this case.

Yes this was one of the downsides of using the code, same thing would have
to be done for oprofile. I'll have to give this a go.

Thanks,
	Zwane
