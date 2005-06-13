Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVFMP0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVFMP0f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVFMP0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:26:34 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:40323 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261614AbVFMPZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:25:58 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 13 Jun 2005 08:25:07 -0700
From: Tony Lindgren <tony@atomide.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2
Message-ID: <20050613152507.GB7862@atomide.com>
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com> <200506130454.j5D4suNY006032@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506130454.j5D4suNY006032@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> [050612 21:55]:
> On Thu, 09 Jun 2005 21:30:18 PDT, Tony Lindgren said:
> 
> > Thanks for all the comments. Here's an updated dyntick patch.
> 
> Patches with 3 minor rejects against -rc6-mm1, boots, and seems to work well on
> my Dell Latitude C840 laptop - although running at full load with seti@home
> causes the expected 250 timer ticks/sec, running a mostly-idle  X session only
> gets about 117, and having xmms and a few other things running it hits about
> 170 tics/sec. I've had the CPU speed bounce between 1.2G and 1.6G a few times
> and it didn't seem to blink either. Even NTP is happy with what it sees.. ;)

Cool.

> Need to rebuild with CONFIG_HZ=1000 and see what it does, and see what it does
> to actual power consumption.

You may also want to check out the patch by Thomas Renninger for ACPI
C-states. I've added a link to it at:

http://muru.com/dyntick/

> Minor nit:  The implementation of /sys/devices/system/timer/timer0/dyn_tick_state
> violates the one-value-per-file rule for sysfs.  I suspect this needs to
> become a directory with 3-4 files in it, each containing one value.

Yeah, I'll clean up that for the next version.

Tony
