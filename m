Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTIKV3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbTIKV3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:29:05 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:21010
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261546AbTIKV27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:28:59 -0400
Date: Thu, 11 Sep 2003 14:29:02 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bill davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030911212902.GC26618@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	bill davidsen <davidsen@tmr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com> <3F60837D.7000209@pobox.com> <20030911162634.64438c7d.ak@suse.de> <3F6087FC.7090508@pobox.com> <bjqk1p$t9r$1@gatekeeper.tmr.com> <1063313075.3881.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063313075.3881.4.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 09:44:35PM +0100, Alan Cox wrote:
> On Iau, 2003-09-11 at 20:56, bill davidsen wrote:
> > | When we know at compile time it's not needed, it should not be enabled.
> > 
> > Clearly that's right. This buys nothing on CPUs which don't have the
> > problem, why have *any* overhead in size and speed? It's too bad that
> > people have to read around all that code, they don't need to give it a
> > home in their RAM and execute it as well.
> 
> We have always built kernels that contained the support for older chips.
> A 586 kernel for example is minutely slowed by the fact it will run on
> the Pentium Pro.
> 
> If someone wants to put in clear "this CPU only" stuff as well then
> fine, but with my distributor hat on I defy you to benchmark the
> difference in the real world between PIV and PIV with 100 bytes of extra
> workaround code.
> 
> You could get that much code back by spending 10 minutes tidying some
> random other piece of code you use, or shortening a couple of printk
> messages.

True, but then why have config options at all?

Why not just put this patch in as is, since it fits with the rest of the way
things are done now, and put it in the to do list for the kernel janitors to
split up the workarounds per cpu, and make config options so they can be
enabled for the specific cpu, and make the generic case just enable a bunch
of those individual cpu config options.

This change won't make it in 2.6, so it belongs in the to do until it has
action taken on it.
