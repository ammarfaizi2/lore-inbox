Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVDGCtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVDGCtM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 22:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVDGCtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 22:49:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19155 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261155AbVDGCtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 22:49:07 -0400
Date: Wed, 6 Apr 2005 22:49:03 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6
Message-ID: <20050407024902.GA9017@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <20050330214455.GF10159@redhat.com> <20050331104117.GD1623@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331104117.GD1623@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 12:41:17PM +0200, Andi Kleen wrote:
 > On Wed, Mar 30, 2005 at 04:44:55PM -0500, Dave Jones wrote:
 > > [apologies to Andi for getting this twice, I goofed the l-k address
 > >  the first time]
 > > 
 > >  
 > >  I arrived at the office today to find my workstation had this spew
 > >  in its dmesg buffer..
 > 
 > Looks like random memory corruption to me.
 > 
 > Can you enable slab debugging etc.?
 > 
 > >  mm/memory.c:97: bad pmd ffff81004b017438(00000038a5500a88).
 > >  mm/memory.c:97: bad pmd ffff81004b017440(0000000000000003).
 > >  mm/memory.c:97: bad pmd ffff81004b017448(00007ffffffff73b).
 > >  mm/memory.c:97: bad pmd ffff81004b017450(00007ffffffff73c).
 > > etc..

I realised today that this happens every time X starts up for
the first time.   I did some experiments, and found that with 2.6.12rc1
it's gone. Either it got fixed accidentally, or its hidden now
by one of the many changes in 4-level patches.

I'll try and narrow this down a little more tomorrow, to see if I
can pinpoint the exact -bk snapshot (may be tricky given they were
broken for a while), as it'd be good to get this fixed in 2.6.11.x
if .12 isn't going to show up any time soon.

		Dave

