Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbVHMO0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbVHMO0V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 10:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVHMO0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 10:26:21 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:13303 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750878AbVHMO0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 10:26:20 -0400
Subject: Re: [PATCH] Convert sigaction to act like other unices
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk,
       gerg@uclinux.org, jdike@karaya.com, sammy@sammy.net,
       lethal@linux-sh.org, wli@holomorphy.com, davem@davemloft.net,
       matthew@wil.cx, geert@linux-m68k.org, paulus@samba.org,
       davej@codemonkey.org.uk, tony.luck@intel.com, dev-etrax@axis.com,
       rpurdie@rpsys.net, spyro@f2s.com, Robert Wilkens <robw@optonline.net>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050813123956.GN22901@wotan.suse.de>
References: <1123900802.5296.88.camel@localhost.localdomain>
	 <20050813123956.GN22901@wotan.suse.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 13 Aug 2005 10:25:51 -0400
Message-Id: <1123943151.5296.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-13 at 14:39 +0200, Andi Kleen wrote:

> <rest snipped which also wasn't better>

Also, what you snipped was another issue, not addressed by the patch.
Some architectures test if the setting up of the signal handler stack
frame succeeded, and others don't.  I believe that this may be a
problem, since it was recently fixed on the x86, and probably should be
addressed on the architectures that don't check for failure.

-- Steve



