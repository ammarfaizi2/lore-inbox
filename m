Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbUDFWoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264055AbUDFWoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:44:54 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:30935 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S264054AbUDFWov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:44:51 -0400
Date: Tue, 6 Apr 2004 15:44:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, p_gortmaker@yahoo.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] don't offer GEN_RTC on ia64
Message-ID: <20040406224450.GJ31152@smtp.west.cox.net>
References: <200404061622.49260.bjorn.helgaas@hp.com> <20040406223416.GH31152@smtp.west.cox.net> <200404061637.48475.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404061637.48475.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 04:37:48PM -0600, Bjorn Helgaas wrote:
> On Tuesday 06 April 2004 4:34 pm, Tom Rini wrote:
> > On Tue, Apr 06, 2004 at 04:22:49PM -0600, Bjorn Helgaas wrote:
> > 
> > > gen_rtc.c doesn't work on ia64 (we don't have asm/rtc.h, for starters),
> > > so don't offer it there.
> > 
> > Why not provide asm/rtc.h and kill off drivers/char/efirtc.c instead? :)
> 
> Yeah, I was afraid someone would suggest that :-)
> 
> I'd actually like to do that, but that's a longer-term project.  And I
> don't know the history behind efi_rtc, so maybe there's a good reason
> for it being separate.
> 
> (Actually, it looks to me like gen_rtc.c ought to be killed off as well,
> with both being folded into rtc.c.)

efi_rtc.c just predates genrtc getting into kernel.org, but as it does
come from the m68k folks, it came first :)  WRT gen_rtc.c being killed
off, yes, that sounds vaugly like the MIPS varriant of a generic RTC
driver, which is being killed off (which reminds me of some cleanups
suggested by Jun Sun, *sigh*, so much to do, so little time).

-- 
Tom Rini
http://gate.crashing.org/~trini/
