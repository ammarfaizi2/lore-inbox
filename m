Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265021AbUD2Wyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265021AbUD2Wyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUD2Wx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:53:57 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:29575 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S265024AbUD2Wwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:52:40 -0400
Date: Thu, 29 Apr 2004 15:52:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ian Campbell <icampbell@arcom.com>, stefan.eletzhofer@eletztrick.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] 2.6 I2C epson 8564 RTC chip
Message-ID: <20040429225238.GB15265@smtp.west.cox.net>
References: <20040429120250.GD10867@gonzo.local> <1083242482.26762.30.camel@icampbell-debian> <20040429135408.G16407@flint.arm.linux.org.uk> <20040429224007.GA15265@smtp.west.cox.net> <20040429234945.M16407@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429234945.M16407@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 11:49:45PM +0100, Russell King wrote:
> On Thu, Apr 29, 2004 at 03:40:07PM -0700, Tom Rini wrote:
> > A generic one for i2c rtcs or another generic rtc driver?  There's
> > already drivers/char/genrtc.c...
> 
> genrtc.c lacks several features ARM needs, the big one being wakeup
> timers.  It also only provides either (configurable) emulation or no
> support of various RTC features, rather than allowing a real RTC to
> provide them if it can - and you need to know the details of your RTC
> at kernel configuration time.

Having hacked at this, and just not having had the time to clean it up a
bit more yet, did you try adding it to genrtc at least?

> It provides no support for translating "RTC" time into seconds and
> vice versa which is needed for second-counter based RTCs found in
> PXA, StrongARM, and other ARM SoC platforms.

It couldn't be added in?

> IOW, its fairly restrictive in what it provides and what it allows
> architectures to provide.

Either way, I'd like to not have 2 generic rtc drivers if at all
possible...

-- 
Tom Rini
http://gate.crashing.org/~trini/
