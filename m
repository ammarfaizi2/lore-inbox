Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270759AbTHFULk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270822AbTHFULk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:11:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2780 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S270759AbTHFULi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:11:38 -0400
Date: Wed, 6 Aug 2003 15:06:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Tomas Szepe <szepe@pinerecords.com>, Ducrot Bruno <poup@poupinou.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus, take two
Message-ID: <20030806130652.GA6914@openzaurus.ucw.cz>
References: <20030805165117.GH18982@louise.pinerecords.com> <Pine.LNX.4.44.0308051006060.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308051006060.23977-100000@cherise>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I think the correct x86 solution would be to introduce a real dummy
> > option for the menus, and imply CONFIG_PM if APM or swsusp (the two
> > options that seem to actually need CONFIG_PM code) is enabled.
> 
> I can buy that. There are actually three levels of power management that 
> we handle:
> 
> - System Power Management (swsusp, CONFIG_ACPI_SLEEP)
> - Device Power Management (kernel/pm.c, future driver model support)
> - CPU Power Management (cpufreq)
> 
> SPM implies that DPM will be enabled, but both DPM and CPM can exist 
> without SPM, and independently of each other. All of them would 
> essentially fall under CONFIG_PM.. 
> 
> Would you willing to whip up a patch for the Kconfig entries? 

We have enough trouble making sure *current* PM code runs with all possible
config combinations; I do not think we want more PM options for now.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

