Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVCUKln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVCUKln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 05:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVCUKln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 05:41:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42988 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261736AbVCUKlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 05:41:37 -0500
Date: Mon, 21 Mar 2005 11:41:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp smp problems... [was Re: swsusp: Remove arch-specific references from generic code]
Message-ID: <20050321104120.GB28507@elf.ucw.cz>
References: <20050316001207.GI21292@elf.ucw.cz> <200503200129.35739.rjw@sisk.pl> <20050320192422.GB1401@elf.ucw.cz> <200503211134.10431.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503211134.10431.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > At least part of them is caused by CONFIG_MTRR. I had to disable it on
> > i386 to make it work...
> 
> Later today I'll check if that helps on x86-64.
> 
> Anyway in the meantime I have played a bit with the CPU hotplug code.
> It needs some work, but looks promising.  I've changed disable_nonboot_cpus()
> to use the CPU hotplug code and it seems to work.  Well, almost, because some
> traces of the second CPU remain in the kernel, as some things do not work
> properly (eg flush_tlb_others() is called with a mask that triggers a BUG()
> in it etc.).  This should not be difficult to get fixed, however.  Strangely enough,
> the processes still fail to freeze after the second CPU has been disabled
> (specifically one of them, which is "syslogd").  I'm going to investigate this
> more thoroughly.
> 
> Turning the second CPU back on does not work for me, but in fact I haven't
> looked at it so far.

Can youm mail me (and probably l-k) the latest diffs? I started
playing with it, too... (remember that scrap-metal machine?).

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
