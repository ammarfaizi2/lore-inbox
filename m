Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbTJUUpZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTJUUpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:45:12 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:44273 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263378AbTJUUo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:44:59 -0400
Date: Tue, 21 Oct 2003 22:37:36 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Carl Thompson <cet@carlthompson.net>
Cc: dongili@supereva.it, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Message-ID: <20031021203736.GF26971@brodo.de>
References: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com> <1066725533.5237.3.camel@laptop.fenrus.com> <20031021095925.GB893@inferi.kami.home> <20031021101737.GA31352@wiggy.net> <20031021105234.GF893@inferi.kami.home> <1066764198.5424d9a4ec004@carlthompson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066764198.5424d9a4ec004@carlthompson.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 12:23:18PM -0700, Carl Thompson wrote:
> > In other words: there is no valid way that a _user_ can set the policy
> > right now: the user can set the frequency, but since any sane policy
> > depends on how busy the CPU is, the user isn't even, the right person to
> > _do_ that, since the user doesn't _know_.
> 
> But userspace _can_ know the idle statistics for each CPU.  It's easily read
> from /proc/stat.

Well, /proc/stat, and kstat_cpu is very inaccurate. There's a project going
on to get better statistics for usage by cpufreq governors. And you really
don't want to export all sorts of statistics every, or every tenth timer 
tick to userspace. But if it's done in kernel-space, and if it's done right,
it may cost really few percentage points of performance.

Even though the governor proposed by Venkatesh may be done as well in
userspace [which I doubt], it's only one of several possible dynamic 
cpufreq governors, most of which will be much faster, leaner and meaner in
kernel space.

	Dominik
