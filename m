Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWH2NPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWH2NPr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWH2NPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:15:46 -0400
Received: from thunk.org ([69.25.196.29]:29668 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964949AbWH2NPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:15:46 -0400
Date: Tue, 29 Aug 2006 09:15:33 -0400
From: Theodore Tso <tytso@mit.edu>
To: linux@horizon.com
Cc: johnstul@us.ibm.com, zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       theotso@us.ibm.com
Subject: Re: Linux time code
Message-ID: <20060829131533.GC31760@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, linux@horizon.com,
	johnstul@us.ibm.com, zippel@linux-m68k.org,
	linux-kernel@vger.kernel.org, theotso@us.ibm.com
References: <1156804609.16398.17.camel@localhost.localdomain> <20060829032829.28776.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829032829.28776.qmail@science.horizon.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 11:28:29PM -0400, linux@horizon.com wrote:
> > While its possible to smooth out the leapsecond (which would be useful
> > to many folks), the problem is one's system would then diverge from UTC
> > for that leapsecond. 
> 
> The Posix-mandated behaviour *requires* diverging from UTC for some
> time period around the leap second.  All you can do is decide how
> to schedule the divergence.

POSIX mandates this for gettimeofday() and CLOCK_REALTIME.  

However, a conforming implementation, could (either in userspace or in
the kernel) provide access to other time bases, include TAI or the
proposed UTS time scales.

						- Ted
