Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268447AbUHLHgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268447AbUHLHgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 03:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268448AbUHLHgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 03:36:32 -0400
Received: from gprs214-50.eurotel.cz ([160.218.214.50]:18820 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268447AbUHLHgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 03:36:31 -0400
Date: Thu, 12 Aug 2004 09:35:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dax Kelson <dax@gurulabs.com>
Cc: trenn@suse.de, seife@suse.de, kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: Allow userspace do something special on overtemp
Message-ID: <20040812073553.GB29466@elf.ucw.cz>
References: <20040811085326.GA11765@elf.ucw.cz> <1092269309.3948.57.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092269309.3948.57.camel@mentorng.gurulabs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This patch cleans up thermal.c a bit, and adds possibility to react to
> > critical overtemp: it tries to call /sbin/overtemp, and only if that
> > fails calls /sbin/poweroff.
> > 
> > Could it be applied?
> 
> Why invent Yet-Another-Call-To-Userland-Interface when either
> hotplug/dbus, netlink or an ACPI event will do?
> 
> The argument "well what if hotplug of acpid don't know what to do" is,
> IMO, bogus since:
> 
> * Obviously systems today are functioning 

Yes, kernel is calling /sbin/poweroff, which everyone has. Switching
to hotplug/dbus would immediately break those systems.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
