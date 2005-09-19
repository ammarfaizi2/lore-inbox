Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVISF3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVISF3I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 01:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVISF3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 01:29:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:55204 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932315AbVISF3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 01:29:07 -0400
Date: Mon, 19 Sep 2005 10:58:30 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
Message-ID: <20050919052830.GB8653@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406> <1127107381.9696.85.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127107381.9696.85.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 03:23:01PM +1000, Nigel Cunningham wrote:
> Maybe I'm just an ignoramus, but I was thinking (without being a
> scheduler expert at all) that if the idle thread was already running,
> trying to set it up to run next might possibly have zero effect. I've

sched_idle_next actually adds the idle task to its runqueue (normally
it is not present in a runqueue while running) and as well changes its 
priority/policy. So it does have *some* effect!

> added a bit of debugging code to try and see in better detail what's
> happening.

Could you elaborate (with some stack traces maybe) on the deadlock you are 
seeing during resume? Maybe that can throw some light.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
