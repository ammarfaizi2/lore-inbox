Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752569AbWKAXdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbWKAXdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbWKAXdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:33:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752569AbWKAXc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:32:59 -0500
Date: Wed, 1 Nov 2006 18:32:50 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Gautham Shenoy <ego@in.ibm.com>
Subject: Re: Remove hotplug cpu crap from cpufreq.
Message-ID: <20061101233250.GA17706@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Gautham Shenoy <ego@in.ibm.com>
References: <20061101225925.GA17363@redhat.com> <Pine.LNX.4.64.0611011507480.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611011507480.25218@g5.osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 03:09:52PM -0800, Linus Torvalds wrote:

 > Hmm. People _have_ given a damn, and I think you were even cc'd.

You're right. In my defense, that stuff arrived the day I went
on vacation for two weeks, and I subsequently forgot all about it.
Looking back over that thread though, a few people seemed to pick a
number of holes in the patches, and there are some real gems in that
thread like.

 > Really, the hotplug locking rules are fairly simple-
 > 
 > 1. If you are in cpu hotplug callback path, don't take any lock.

Which is just great, as afair, the cpufreq locks were there _before_
someone liberally sprinkled lock_cpu_hotplug() everywhere.

 > Right now, for 2.6.19, I'd prefer to not touch that mess unless there are 
 > known conditions that actually cause more problems than just stupid 
 > warnings..

>From what I can tell from looking at that thread back in August,
it went on for a while with a number of people picking holes in the
proposed patches, but there wasn't any reposted after that, and
certainly nothing that ended up in -mm.

_something_ needs to be done. If someone wants to fix it, great, but
until we see something mergable, we're left in this half-assed state
which is freaking people out.

	Dave

-- 
http://www.codemonkey.org.uk
