Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWA1XLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWA1XLV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 18:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWA1XLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 18:11:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44970 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750786AbWA1XLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 18:11:21 -0500
Date: Sun, 29 Jan 2006 00:10:58 +0100
From: Pavel Machek <pavel@suse.cz>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: Matthew Dobson <colpatch@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org, andrea@suse.de,
       linux-mm@kvack.org
Subject: Let the flames begin... [was Re: [patch 3/9] mempool - Make mempools NUMA aware]
Message-ID: <20060128231058.GA1718@elf.ucw.cz>
References: <43D96633.4080900@us.ibm.com> <Pine.LNX.4.62.0601261619030.19029@schroedinger.engr.sgi.com> <43D96A93.9000600@us.ibm.com> <20060127025126.c95f8002.pj@sgi.com> <43DAC222.4060805@us.ibm.com> <20060128081641.GB1605@elf.ucw.cz> <43DB9877.7020206@us.ibm.com> <20060128164158.GD1858@elf.ucw.cz> <43DBA1A0.6010708@us.ibm.com> <20060128225907.GA1612@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128225907.GA1612@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 28-01-06 23:59:07, Pavel Machek wrote:
> Hi!
> 
> > >If sending routines can work with constant ammount of memory, why use
> > >kmalloc at all? Anyway I thought we were talking receiving side
> > >earlier in the thread.
> > >
> > >Ouch and wait a moment. You claim that GFP_KERNEL allocations can't
> > >block/sleep? Of course they can, that's why they are GFP_KERNEL and
> > >not GFP_ATOMIC.
> > >  
> > I didn't meant GFP_KERNEL allocations cannot block/sleep? When in 
> > emergency, we
> > want even the GFP_KERNEL allocations that are made by critical sockets 
> > not to block/sleep.
> > So my original critical sockets patches changes the gfp flag passed to 
> > these allocation requests
> > to GFP_KERNEL|GFP_CRITICAL.

(I'd say Al Viro mode, but Al could take that personally)

IOW: You keep pushing complex and known-broken solution for problem
that does not exist.

(Now you should be angry enough, and please explain why I'm wrong in
easy to understand terms, so that even I will understand that we need
critical sockets for kernels in emergency).
								Pavel
-- 
Thanks, Sharp!
