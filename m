Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUCIWLu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUCIWLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:11:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:36807 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261821AbUCIWLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:11:48 -0500
Subject: Re: ACPI PM Timer vs. C1 halt issue
From: john stultz <johnstul@us.ibm.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com
In-Reply-To: <404E38B7.5080008@gmx.de>
References: <404E38B7.5080008@gmx.de>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1078870289.12084.8.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 09 Mar 2004 14:11:30 -0800
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-09 at 13:35, Prakash K. Cheemplavam wrote:
> I found out what causes higher idle temps when using mm-sources and 
> 2.6.4-rc vanilla sources: If I use PM Timer as timesource, it seems the 
> C1 halt isn't properly called, at least CPU disconnect doesn't seem to 
> work, thus leaving my CPU as hot as without disconnect.
> 
> using tsc timesource: idle temps of about 45-47°C
> using pm timer: 52-53°C idle temps
> 
> Is this a bug or a feature?
> 
> I have nforce2 hardware. Tell me if you need anything else.

Sounds like a bug. I'm not very familiar w/ the ACPI cpu power states,
is there anything you have to do to trigger C1 Halt? Or is it just
called in the idle loop?

thanks
-john

thanks
-john

