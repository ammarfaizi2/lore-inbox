Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVKEQMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVKEQMP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVKEQMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:12:15 -0500
Received: from outbound04.telus.net ([199.185.220.223]:10374 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S1751210AbVKEQMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:12:14 -0500
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@cpushare.com>
Subject: Re: disable tsc with seccomp
Date: Sat, 5 Nov 2005 17:12:09 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20051105134727.GF18861@opteron.random> <200511051637.44432.ak@suse.de> <20051105160720.GB14064@opteron.random>
In-Reply-To: <20051105160720.GB14064@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511051712.09280.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 November 2005 17:07, Andrea Arcangeli wrote:
> On Sat, Nov 05, 2005 at 04:37:44PM +0100, Andi Kleen wrote:
> > It was useless, you can get exactly the same information by using RDPMC
> > on perfctr 0 which always runs the NMI watchdog and counts all cycles
> > too.
>
> nmi watchdog is off in my system, but it was used to be very slow.

It is normally on on all x86-64 systems.

> Anyway performance counters should be turned off too. They can be turned
> off on a per task basis right? Just switching another cr4 bit or what?

I definitely don't want any code like this in the context switch. It is 
critical and I don't want to pollute fast paths with stuff like this
that nobody needs.

-Andi
