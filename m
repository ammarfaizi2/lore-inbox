Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263628AbUEEHtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbUEEHtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 03:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUEEHtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 03:49:09 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:5134 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263628AbUEEHtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 03:49:05 -0400
Date: Wed, 5 May 2004 00:44:56 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@osdl.org, ashok.raj@intel.com, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com,
       jreiser@BitWagon.com, mike@navi.cx, pageexec@freemail.hu,
       colpatch@us.ibm.com, rusty@rustcorp.com.au, nickpiggin@yahoo.com.au
Subject: Re: various cpu patches [was: (resend) take3: Updated CPU Hotplug
 patches]
Message-Id: <20040505004456.4fd397f0.pj@sgi.com>
In-Reply-To: <20040505072431.GG1397@holomorphy.com>
References: <20040504211755.A13286@unix-os.sc.intel.com>
	<20040504225907.6c2fe459.akpm@osdl.org>
	<20040505000348.018f88bb.pj@sgi.com>
	<20040505072431.GG1397@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see any essential interaction between these patches.

Essentially, yes.  The interactions were:

 Ashok's Hotplug added an essential arch-specific ifdef to a
  arch-specific cpumask file that my cleanup removes - so I had
  to work with Ashok to remove that arch dependency.

 Reiser's bssprot broke ia64, so I couldn't test with that patch.

 Matthew has recoded his nodemask patch to presume my cpumask cleanup.

 Andi's numa patch is so far as we know independent, but close enough
  to all this other activity to be at risk for something.

The interactions were enough that I probably couldn't expect Andrew to
wade through them to adapt my cleanup.  Rather I pretty much have to
deliver my cleanup ready to go, with whatever Andrew thinks is his
current *-mm series.

I'll be doing well just to get Andrew to look at it, despite what I take
to be endorsements from Matthew, Rusty and Joe Korty, and conditional
acceptance from yourself.  Andrew would probably drop it in a heartbeat
if it collided non-trivially.

So merge work - yes.  But merge work that mostly I need to do, which
makes me very sensitive to the order in which things happen.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
