Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266732AbUHOOwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266732AbUHOOwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUHOOwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:52:18 -0400
Received: from gprs212-247.eurotel.cz ([160.218.212.247]:41088 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266732AbUHOOsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:48:06 -0400
Date: Sun, 15 Aug 2004 16:46:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, lhcs-devel@lists.sourceforge.net
Subject: Re: [lhcs-devel] Re: [PATCH][2.6-mm] i386 Hotplug CPU
Message-ID: <20040815144655.GA784@elf.ucw.cz>
References: <1090870667.22306.40.camel@pants.austin.ibm.com> <20040726170157.7f4b414c.akpm@osdl.org> <Pine.LNX.4.58.0407270137510.25781@montezuma.fsmlabs.com> <Pine.LNX.4.58.0407270440200.23985@montezuma.fsmlabs.com> <20040811135019.GC1120@openzaurus.ucw.cz> <Pine.LNX.4.58.0408112043100.2544@montezuma.fsmlabs.com> <Pine.LNX.4.58.0408142313450.22078@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408142313450.22078@montezuma.fsmlabs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yeah i recall you mentioning this earlier, i'll look into adding the
> > necessary bits so that you have enough state to resume from. Your
> > mentioning this was one of the reasons i wanted this in.
> 
> Pavel, considering that the processor is in a quiescent state when it's in
> the idle thread, can't we simply restart them all when we do the final
> sleep? So on the resume, we steer the APs straight into the offline cpu
> spin and manually bring them up again when the BSP has resumed? I
> reckon

Sorry, I do not understand what AP and BSP means in this context.

> we don't have to save any state at all. I probably don't have the full
> picture yet so feel free to set me straight.

Yes, we can just shut those cpus down on suspend and completely boot
them from real mode during resume... that should work. And we will
need to do that during suspend-to-ram.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
