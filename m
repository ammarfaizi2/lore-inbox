Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVHDQ0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVHDQ0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVHDQ0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:26:17 -0400
Received: from pop.gmx.de ([213.165.64.20]:13490 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262536AbVHDQ0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:26:14 -0400
X-Authenticated: #1725425
Date: Thu, 4 Aug 2005 18:25:13 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Christian Leber <christian@leber.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-Id: <20050804182513.769e1887.Ballarin.Marc@gmx.de>
In-Reply-To: <20050803232236.GA13520@core.home>
References: <200508031559.24704.kernel@kolivas.org>
	<20050803232236.GA13520@core.home>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005 01:22:36 +0200
Christian Leber <christian@leber.de> wrote:

> Just a few numbers:
> 
> I tried it on a Laptop (Dell C810, P3m 1133 mhz) and measured the power
> usage with an external device and it stayed with or without patch at
> 27W. (HZ was at about 28)

Does your machine enter C3 state? Check the usage
in /proc/acpi/processor/CPU0/power

If usage is 0, unplug all USB peripherals (at least those connected to
uhci controllers). Also shut down sound servers.

Without C3, there won't be any power savings from lower HZ. Desktop CPUs
often don't support C3 at all.

Marc
