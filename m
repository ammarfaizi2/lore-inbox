Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269262AbUJKVb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269262AbUJKVb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbUJKVb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:31:59 -0400
Received: from cantor.suse.de ([195.135.220.2]:47839 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269262AbUJKVbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:31:55 -0400
Date: Mon, 11 Oct 2004 23:25:29 +0200
From: Andi Kleen <ak@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 HPET compile problems on AMD64
Message-ID: <20041011212529.GB31731@wotan.suse.de>
References: <1097509362.12861.334.camel@dyn318077bld.beaverton.ibm.com> <20041011125421.106eff07.akpm@osdl.org> <1097526413.12861.374.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097526413.12861.374.camel@dyn318077bld.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 01:26:53PM -0700, Badari Pulavarty wrote:
> On Mon, 2004-10-11 at 12:54, Andrew Morton wrote:
> 
> > 
> > I assume you have CONFIG_HPET=n and CONFIG_HPET_TIMER=n?
> > 
> > Andi, what's going on here?  Should the hpet functions in
> > arch/x86_64/kernel/time.c be inside CONFIG_HPET_TIMER?
> 
> I haven't enable HPET, but autoconf.h gets 
> 
> # grep HPET autoconf.h
> #define CONFIG_HPET_TIMER 1
> #define CONFIG_HPET_EMULATE_RTC 1
> 
> # grep HPET .config
> # CONFIG_HPET is not set

It should be inside CONFIG_HPET. Badari's patch was correct.

-Andi
