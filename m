Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbVCDLyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbVCDLyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVCDLyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:54:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3783 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262785AbVCDL1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:27:09 -0500
Date: Fri, 4 Mar 2005 12:26:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling while atomic errors on swsusp resume
Message-ID: <20050304112649.GQ1345@elf.ucw.cz>
References: <1109811404.5918.80.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109811404.5918.80.camel@tyrosine>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Using the current Ubuntu development kernel (2.6.10 with acpi and swsusp
> stuff backported from 2.6.11), a user is getting the following trace on
> resume. Passing noapic nolapic removes the APIC error, but the rest of
> the trace is identical. This is reproducible, but only seems to happen
> on this machine. Anyone have any idea what's going on before I head off
> to try getting it reproduced with a stock kernel?

Well, those are warnings, so it still works, right? Aha, "exited with
preempt count 1" seems very wrong. Yes, please try this with
vanilla. I'm running 2.6.11 with 

CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y

and I certainly do not get these ugly warnings.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
