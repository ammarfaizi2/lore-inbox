Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWISS2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWISS2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWISS2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:28:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31211 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750788AbWISS2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:28:51 -0400
Date: Tue, 19 Sep 2006 14:28:28 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Ayaz Abdulla <aabdulla@nvidia.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] forcedeth: hardirq lockdep warning
Message-ID: <20060919182828.GC3929@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ayaz Abdulla <aabdulla@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>,
	Arjan van de Ven <arjan@linux.intel.com>
References: <1158670522.3278.13.camel@taijtu> <20060919111448.9274c699.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919111448.9274c699.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 11:14:48AM -0700, Andrew Morton wrote:
 > On Tue, 19 Sep 2006 14:55:22 +0200
 > Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
 > 
 > > BUG: warning at kernel/lockdep.c:1816/trace_hardirqs_on() (Not tainted)
 > 
 > I wonder what line that was.  DEBUG_LOCKS_WARN_ON(current->hardirq_context),
 > I suppose.

That's what it matches up to in the Fedora kernel. (We have a bunch of lockdep
fixes scooped up from lkml over the last month or so, which may offset us).

	Dave
