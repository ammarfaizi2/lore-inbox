Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264649AbUEJLfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbUEJLfT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 07:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUEJLep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 07:34:45 -0400
Received: from gizmo01bw.bigpond.com ([144.140.70.11]:28818 "HELO
	gizmo01bw.bigpond.com") by vger.kernel.org with SMTP
	id S264647AbUEJLc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 07:32:59 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: cbradney@zip.com.au
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
Date: Mon, 10 May 2004 21:37:11 +1000
User-Agent: KMail/1.5.1
Cc: Ian Kumlien <pomac@vapor.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, a.verweij@student.tudelft.nl,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       christian.kroener@tu-harburg.de,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Allen Martin <AMartin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405102137.11468.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney wrote

>Well.. 2.6.6 is released.. and THANK YOU Linus and all the patch 
> writers.. we have nforce2 fixes in the released kernel now. I'm just 
> waiting for a gentoo-dev-sources release now.. 
> 
>
>
>Craig 

MOMENT PLEASE.
ALMOST complete nforce2 support. Job not done yet.

Unfortunately 2.6.6 still has the old check_timer code which inhibits
nmi_watchdog=1 on all nforce2 from working by having timer_ack=1
when checking io-apic pit routing.

It is a hardware issue - NOT A BUGGY BIOS ISSUE inside the integrated 
nforce2 interrupt routing.

To my understanding IT WILL NEVER BE FIXED BY A BIOS REVISION and 
after reading the 8259 datasheets I think it is a mistake within the
existing code to have the timer_ack on there in the first place. 

I would still like to see Maciej's check_timer patch in the kernel. It was
pulled after only a single user mobo complaint was posted yet it helps
both nforce2 and ibm bios pc's. To my knowledge little effort was made
by that user to accomodate the patch - it was just outright pulled in spite
of its benefit to others?

Who do we ask to revisit this? Linus? the io-apic.c maintainer? or the one
user with a complaint?

That patch that was dropped by Linus? after appearing in 2.6.3-mm3. 
For those nforce2 users with problems of clock skew with the timer into pin0
routing, that patch gave a virtual wire timer routing which worked well.

It also works around serious problems for ibm users who also want it in.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/4421.html

Regards
Ross.


