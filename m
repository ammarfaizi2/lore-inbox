Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUBESRC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUBESRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:17:02 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:64010
	"EHLO muru.com") by vger.kernel.org with ESMTP id S266615AbUBESQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:16:57 -0500
Date: Thu, 5 Feb 2004 10:17:05 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040205181704.GC7658@atomide.com>
References: <20040131203512.GA21909@atomide.com> <20040203131432.GE550@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203131432.GE550@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [040205 06:03]:
> Hi!
> 
> > Following is a little patch to do a sanity check on the max speed and 
> > voltage values provided by the bios.
> > 
> > Some buggy bioses provide bad values if the cpu changes, for example, in 
> > my case the bios claims the max cpu speed is 1600MHz, while it's running at
> > 1800MHz. (Cheapo Emachines m6805 you know...) This could also happen on 
> > machines where the cpu is upgraded.
> > 
> > These checks should be safe, as they only change things if the machine is
> > already running at a higher speed than the bios claims.
> > 
> 
> Someone should really bug them to fix their BIOS. (BTW does keyboard work
> ok for you?) 

No problems with keyboard, and the cpufreq works fine with the patch, but
not at all without the patch.

There are some ACPI related issues though, such as: via-rhine gets wrong 
irq with ACPI on, system hangs with yenta_socket loaded if I 
connect/disconnect the power cord... So for now, I don't use the PCMCIA.

> Going though ACPI solves this, and I have perhaps better
> patch to hardcode right values...

Still, the max speed check should be safe. Maybe pass values as module
options too? I would not trust on ACPI working right on this machine :)

Tony
