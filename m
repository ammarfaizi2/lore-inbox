Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVKNAg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVKNAg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 19:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVKNAg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 19:36:29 -0500
Received: from fsmlabs.com ([168.103.115.128]:10191 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750810AbVKNAg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 19:36:29 -0500
X-ASG-Debug-ID: 1131928584-16917-87-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sun, 13 Nov 2005 16:42:10 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Raj, Ashok" <ashok.raj@intel.com>
cc: Andrew Morton <akpm@osdl.org>, Nathan Lynch <nathanl@austin.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, ak@muc.de,
       rusty@rustycorp.com.au, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       jschopp@austin.ibm.com,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Dave Jones <davej@redhat.com>
X-ASG-Orig-Subj: RE: Documentation for CPU hotplug support
Subject: RE: Documentation for CPU hotplug support
In-Reply-To: <A28EFEDC5416054BA1026D892753E9AF0BBDD08C@orsmsx404.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.61.0511131508530.24091@montezuma.fsmlabs.com>
References: <A28EFEDC5416054BA1026D892753E9AF0BBDD08C@orsmsx404.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5268
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2005, Raj, Ashok wrote:

> >
> >Ashok was my patch for the cpufreq driver *that* horrible? Or perhaps
> we
> >just need to move things like the set_cpus_allowed further up in the
> calls
> >and handle everything in one location. Interested?
> >
> 
> I have been on to multiple things recently, I think I saw your post, but
> didn't look at it closer.
> 
> Yes, moving things higher up would definitely help, especially the
> set_cpus_allowed(). 
> 
> We should also do the same for the case where we have the list of
> dependent cpus in the mask before calling the lower level functions. 
> 
> Zwane, if you want to take a shot at it, that would be awesome.. I might
> not be able to get to this immediately.

Urgh making it generic turned out to be fairly complicated due to the 
number of sleeping calls done from the lowlevel drivers and handling the 
disabling and enabling of preemption just got too ugly.
