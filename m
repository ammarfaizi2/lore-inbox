Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVEWThS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVEWThS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 15:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVEWThS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 15:37:18 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:42911 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261934AbVEWThL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 15:37:11 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@muc.de>
Subject: Re: [patch 2/4] CPU hot-plug support for x86_64
Date: Mon, 23 May 2005 21:37:07 +0200
User-Agent: KMail/1.8
Cc: Ashok Raj <ashok.raj@intel.com>, zwane@arm.linux.org.uk,
       discuss@x86-64.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050520223417.532048000@csdlinux-2.jf.intel.com> <20050523163816.GA39821@muc.de>
In-Reply-To: <20050523163816.GA39821@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505232137.08464.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 23 of May 2005 18:38, Andi Kleen wrote:
> On Fri, May 20, 2005 at 03:16:24PM -0700, Ashok Raj wrote:
> > Experimental CPU hotplug patch for x86_64
> > -----------------------------------------
> > - Most of init code that needs to be there for hotplug marked now as __devinit
> > 	(Didn't use cpuinit, simply because the main framework code in kernel
> > 	 is not the same way, just trying to be consistent)
> 
> I dont like that. Can you keep it as __cpuinit please?  e.g. 
> if cpuhot plug turns out to be a lot of code we could later
> mark it free when we detect at boot the system does not support
> cpu hotplug. With devinit that is pretty much impossible these days.

Please note that CPU hotplug will be necessary for swsusp on SMP systems
(e.g. dual-core).  It seems that currently __cpuinit <=> __init, so it's not
quite suitable for this purpose.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
