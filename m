Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752660AbVHGT7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbVHGT7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbVHGT7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:59:16 -0400
Received: from fsmlabs.com ([168.103.115.128]:34958 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1752660AbVHGT7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:59:16 -0400
Date: Sun, 7 Aug 2005 14:04:46 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
cc: Andi Kleen <ak@suse.de>, Erick Turnquist <jhujhiti@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks on x86_64
In-Reply-To: <1123440679.12766.5.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0508071402500.470@montezuma.fsmlabs.com>
References: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel>
  <p73mznuc732.fsf@bragg.suse.de> <1123440679.12766.5.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Aug 2005, Lee Revell wrote:

> > It's most likely bad SMM code in the BIOS that blocks the CPU too long
> > and is triggered in idle. You can verify that by using idle=poll
> > (not recommended for production, just for testing) and see if it goes away.
> > 
> 
> WTF, since when do *desktops* use SMM?  Are you telling me that we have
> to worry about these stupid ACPI/SMM hardware bugs on the desktop too?

It's a general platform thing and has been around for ages now... 
Intel's ICH* definitely use it for example and those are on a lot of 
desktop systems. For example, turning on "Legacy USB support" will 
generate periodic SMIs.

