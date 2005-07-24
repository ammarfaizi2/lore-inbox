Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVGXRB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVGXRB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 13:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVGXRBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 13:01:25 -0400
Received: from tim.rpsys.net ([194.106.48.114]:12960 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261404AbVGXRBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 13:01:22 -0400
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pavel Machek <pavel@suse.cz>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
In-Reply-To: <20050724174756.A20019@flint.arm.linux.org.uk>
References: <20050722180109.GA1879@elf.ucw.cz>
	 <20050724174756.A20019@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 24 Jul 2005 18:01:12 +0100
Message-Id: <1122224472.7585.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-24 at 17:47 +0100, Russell King wrote:
> On Fri, Jul 22, 2005 at 08:01:09PM +0200, Pavel Machek wrote:
> > This adds support for reading ADCs (etc), neccessary to operate touch
> > screen on Sharp Zaurus sl-5500.
> 
> I would like to know what the diffs are between my version (attached)
> and this version before they get applied.
> 
> The only reason my version has not been submitted is because it lives
> in the drivers/misc directory, and mainline kernel folk don't like
> drivers which clutter up that directory.  In fact, I had been told
> that drivers/misc should remain completely empty - which makes this
> set of miscellaneous drivers homeless.

I've been wondering about suggesting the creation of a drivers/soc
directory. The idea would be for it to contain "system on chip" type
support code. I use that description loosely to fit any code which needs
to support drivers in multiple driver subsections.

An example use in my Zaurus tree is the TSC2101 which contains a
touchscreen, battery monitoring and sound. Handhelds.org has devices
such as the ASIC2/ASIC3 in the ipaqs (and other handhelds) which cover
many different drivers subsections.

Where practical, the sub drivers such as the touchscreen could be placed
into the specific driver areas such as drivers/input/touchscreen/ but
the core chip specific support would be in drivers/soc and the files
would be connected. 

Would that be acceptable in mainline?

Richard








