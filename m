Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVJNSEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVJNSEQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVJNSEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:04:16 -0400
Received: from mail.suse.de ([195.135.220.2]:59058 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750777AbVJNSEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:04:15 -0400
Date: Fri, 14 Oct 2005 20:04:14 +0200
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2.6.14-rc4] i386: spinlock optimization
Message-ID: <20051014180414.GD3502@verdi.suse.de>
References: <200510141350_MC3-1-ACA0-C8C9@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510141350_MC3-1-ACA0-C8C9@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 01:47:09PM -0400, Chuck Ebbert wrote:
> Attempt to acquire spinlock sooner after spinning and then noticing
> it has become available.  Also adds a slight delay before testing the
> spinlock again when it's not available, reducing bus traffic.

I doubt your change adds any noticeable delay on a aggressive
OOO CPU, which are pretty much all modern x86s. It's probably
a nop.

-Andi

