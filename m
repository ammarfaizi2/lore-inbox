Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVGITox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVGITox (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 15:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVGITox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 15:44:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:49869 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S261716AbVGITow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 15:44:52 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-Id: <200507091944.j69Jhv5Y008419@einhorn.in-berlin.de>
Date: Sat, 9 Jul 2005 21:43:57 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [2.6 patch] drivers/ieee1394/: schedule unused EXPORT_SYMBOL's
 for removal
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
cc: bcollins@debian.org, scjody@modernduck.com, bunk@stusta.de
In-Reply-To: <20050709185557.GI28243@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
X-Spam-Score: (-0.665) AWL,BAYES_00,MSGID_FROM_MTA_ID
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, Jul 09, 2005 at 03:50:35AM -0400, Ben Collins wrote:
>> Can we, instead of removing these, wrap then in a "Export full API" config
>> option? I've already got several reports from external projects that are
> 
> This will end in all distributions having this option enabled resulting 
> in no change compared to todays status quo.

I disagree. Distributors, especially those oriented towards private/
SOHO/ big commercial customers, don't need to care much for classroom
projects or the hacker next door. Distributors will not enable this
option once it defaults to off in mainline. This config option is
ultimately *no* solution for commercial support of external drivers,
regardless whether they are free software or unfree. The patch does not
attempt to establish a warranted managed API.

>> using most of these exported symbols, and I'd hate to make it harder on
>> them to use our drivers (for internal projects or otherwise).
> 
> What are these external projects?

There are countless FireWire related projects, especially in academia.
For example, FireWire seems to be a hit in robotics. We at
linux1394-devel may not even hear about what they are doing in
particular but we do get feedback, bugfixes, and improvements from them.
For them, Linux' IEEE 1394 stack may be only one choice out of several,
including stacks in the big desktop operating systems or in various
embedded OSs. So in my personal opinion, it is in best interest for
Linux' 1394 stack if we can keep these people motivated to stick with
Linux.

> Is they are internal projects, re-adding the EXPORT_SYMBOL's should be 
> trivial for them.

We make it even more trivial by providing a compile option for that. The
cost is minimal.
-- 
Stefan Richter
-=====-=-=-= -=== -=--=
http://arcgraph.de/sr/

