Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSGLRz3>; Fri, 12 Jul 2002 13:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSGLRz2>; Fri, 12 Jul 2002 13:55:28 -0400
Received: from ns.suse.de ([213.95.15.193]:24081 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316750AbSGLRz1>;
	Fri, 12 Jul 2002 13:55:27 -0400
Date: Fri, 12 Jul 2002 19:58:15 +0200
From: Dave Jones <davej@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Daniel Phillips <phillips@arcor.de>, Jesse Barnes <jbarnes@sgi.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: spinlock assertion macros
Message-ID: <20020712195815.F16956@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Robert Love <rml@tech9.net>, Daniel Phillips <phillips@arcor.de>,
	Jesse Barnes <jbarnes@sgi.com>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17SWXm-0002BL-00@starship> <20020711180326.GH709072@sgi.com> <E17SjRh-0002VI-00@starship> <20020712140751.A14671@suse.de> <1026496182.1352.385.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1026496182.1352.385.camel@sinai>; from rml@tech9.net on Fri, Jul 12, 2002 at 10:49:42AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 10:49:42AM -0700, Robert Love wrote:

 > > When I came up with the idea[1] I envisioned some linked-lists frobbing,
 > > but in more recent times, we can now check the preempt_count for a
 > > quick-n-dirty implementation (without the additional info of which locks
 > > we hold, lock-taker, etc).
 > 
 > Neat idea.  I have seen some other good similar ideas: check
 > preempt_count on schedule(), check preempt_count in usleep/msleep
 > (Arjan's idea), and check preempt_count in wakeup/context switch/etc.
 > code...

Sounds sensible. I'd like to see more self-checking bits added for
preemption. It may be the only way we ever pin down some of the
outstanding "don't make any sense" bugs.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
