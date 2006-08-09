Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWHIMHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWHIMHh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWHIMHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:07:37 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:438 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1161001AbWHIMHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:07:36 -0400
Date: Wed, 9 Aug 2006 14:07:34 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Suspend2-devel@lists.suspend2.net, linux-pm@osdl.org,
       ncunningham@linuxmail.org
Subject: Re: swsusp and suspend2 like to overheat my laptop
Message-ID: <20060809120734.GA30544@rhlx01.fht-esslingen.de>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com> <20060808235352.GA4751@elf.ucw.cz> <Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com> <20060809073958.GK4886@elf.ucw.cz> <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 07:45:23AM -0400, Steven Rostedt wrote:
> It does look like something isn't setting up the ACPI power properly on
> resume, and that the CPU is probably in a busy loop while the machine is
> idle.  Just a guess.

In that case could you post
cat /proc/acpi/processor/CPU?/*
?

Perhaps we're losing ACPI C2/C3 state power saving, and checking
the busmaster activity indicators there would be useful, too.

Oh, in this context maybe it's actually a problem of a misbehaving driver?
An active USB mouse is known to distort ACPI power saving, causing reduced
notebook battery operation length (due to busmaster activity preventing
ACPI idling, I think). Now what if some certain driver actually caused
permanent busmaster activity...?

Andreas Mohr
