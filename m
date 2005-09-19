Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVISFf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVISFf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 01:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVISFf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 01:35:26 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:52696 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932316AbVISFf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 01:35:26 -0400
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: vatsa@in.ibm.com
Cc: Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20050919052830.GB8653@in.ibm.com>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
	 <1127107381.9696.85.camel@localhost>  <20050919052830.GB8653@in.ibm.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1127108122.9696.90.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 19 Sep 2005 15:35:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 15:28, Srivatsa Vaddagiri wrote:
> On Mon, Sep 19, 2005 at 03:23:01PM +1000, Nigel Cunningham wrote:
> > Maybe I'm just an ignoramus, but I was thinking (without being a
> > scheduler expert at all) that if the idle thread was already running,
> > trying to set it up to run next might possibly have zero effect. I've
> 
> sched_idle_next actually adds the idle task to its runqueue (normally
> it is not present in a runqueue while running) and as well changes its 
> priority/policy. So it does have *some* effect!

Ok.

> > added a bit of debugging code to try and see in better detail what's
> > happening.
> 
> Could you elaborate (with some stack traces maybe) on the deadlock you are 
> seeing during resume? Maybe that can throw some light.

I'll try. I'm having trouble reproducing it now (yes, having reversed my
patch!).

Regards,

Nigel
-- 


