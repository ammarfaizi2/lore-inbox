Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264041AbTE3WTq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbTE3WTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:19:46 -0400
Received: from main.gmane.org ([80.91.224.249]:16082 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264092AbTE3WTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:19:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: local apic timer ints not working with vmware: nolocalapic
Date: Fri, 30 May 2003 18:14:37 -0400
Message-ID: <pan.2003.05.30.22.14.35.511205@interlinx.bc.ca>
References: <2C8EEAE5E5C@vcnet.vc.cvut.cz> <20030528173432.GA21379@linux.interlinx.bc.ca> <Pine.LNX.4.50.0305281341160.1982-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003 13:42:13 -0400, Zwane Mwaikambo wrote:
> 
> I submitted a patch for nolapic before...

Did you get any response as to whether it was going to be accepted into
the kernel or not?

The unfortunate thing is that even this sort of fix will not help my
situation.  The reason being (which I only discovered by accident when I
set "dont_enable_local_apic = 1" rather than "dont_use_local_apic_timer"
and it didn't correct the booting problem) is that it seems that even if
the local apic is set disabled by setting dont_enable_local_apic = 1 in
arch/i386/kernel/apic.c, setup_APIC_clocks() is still called.

So the jist is that using the local apic timer feature is not dependent on
using the local apic, as per the dont_enable_local_apic and
dont_use_local_apic_timer flags in arch/i386/kernel/apic.c.  Maybe this is
wrong, I dunno unfortunately.

I don't know anything about this APIC stuff so I don't know if that is
correct or not, but it is what happens.

Thanx for the input though, much appreciated,

b.


