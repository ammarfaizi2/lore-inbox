Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbVAFWCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbVAFWCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbVAFWCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:02:36 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:22434 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263058AbVAFWAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:00:30 -0500
Date: Thu, 6 Jan 2005 22:00:09 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Swapoff inifinite loops on 2.6.10-bk (was: .6.10-bk8 swapoff
    after resume)
In-Reply-To: <1105046085.1087.29.camel@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.44.0501062152380.3177-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Martin Josefsson wrote:
> On Thu, 2005-01-06 at 14:47 +0100, Lukas Hejtmanek wrote:
> 
> > I've tried 2.6.10-bk8 suspend/resume. After resume I usually do swapoff -a to
> > load all the pages from swap to memory. Unfortunately with the latest version
> > swapoff does not work. It seems to cycle in an endless loop reading data from 
> > disk.
> 
> I second that, after resume my machine does exactly the same.
> It swaps in most of the data, but it leaves ~1700kB on the swapdevice
> that it doesn't manage to swap in, and apparently reads this over and
> over again.
> 
> But it probably doesn't have anything to do with swsusp, I can reproduce
> it without ever having suspended, just fill up the memory so the machine
> swaps and then the same thing happens.
> 
> Apparently kernels from -bk in late december works fine, so it's a
> recent introduction.
> Needs investigating.

Curious.  I regularly check that swapoff is working (though not suspend
and resume), and have not noticed this.  You fill memory so the machine
swaps, let the memory hog exit, then swapoff hangs indefinitely (not just
taking a long time)?  With no suspend+resume since booting at all?

How much memory?  How much swap?  What .config?  I'll try it tomorrow.

Thanks,
Hugh

