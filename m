Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbTEPSTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTEPSTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:19:04 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:17215 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264538AbTEPSTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:19:03 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <1053107295.2606.21.camel@toshiba>
References: <Pine.LNX.4.44L0.0305161307390.1171-100000@ida.rowland.org>
	 <1053107295.2606.21.camel@toshiba>
Content-Type: text/plain
Organization: 
Message-Id: <1053109899.2606.46.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 16 May 2003 13:31:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 12:48, Paul Fulghum wrote:
> So always allowing suspend, and selectively doing the
> wakeup will cause:
> 1. thrashing for case of one port OC,
> other port OK with attached device.
> 2. prevent port with OC from doing resume
> after clearing OC condition.
> 
> For the case of all ports hardwired OC, this
> will work because you suspend the whole controller
> and never get a valid resume.

Just to add another argument to disallowing suspend
instead of qualifying wakeup:

In 99% of cases, with no OC, this won't come into play.
In .9% of cases, with transient OC, this won't delay suspend long.
In .01% of cases, with all hardwired OC ports, suspend does not matter.

Plus it cures the above problems #1 and #2.

If problem #1 occurs, I don't see that thrashing is
any better than not suspending at all.


-- 
Paul Fulghum
paulkf@microgate.com

