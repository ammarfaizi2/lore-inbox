Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUAQWBa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 17:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUAQWBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 17:01:30 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:42207 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S266202AbUAQWB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 17:01:28 -0500
Date: Sat, 17 Jan 2004 14:01:10 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Sander <sander@humilis.net>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: several oopses during boot (was: Re: [PATCH] Add CONFIG for -mregparm=3)
Message-ID: <20040117220110.GB1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Andi Kleen <ak@colin2.muc.de>,
	Sander <sander@humilis.net>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, jh@suse.cz
References: <20040114090603.GA1935@averell> <20040117201639.GA16420@favonius> <20040117205302.GA16658@colin2.muc.de> <20040117210715.GA15172@favonius> <20040117212857.GA28114@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117212857.GA28114@colin2.muc.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 10:28:57PM +0100, Andi Kleen wrote:
> On Sat, Jan 17, 2004 at 10:07:15PM +0100, Sander wrote:
> > Andi Kleen wrote (ao):
> > > > 2.6.1-mm4
> > > 
> > > Note that this kernel is broken on gcc 3.4 and on 3.3-hammer. If
> > > you're using that disable the -funit-at-a-time setting in the main
> > > Makefile.
> > 
> > > > VIA C3 Ezra
> > > > 
> > > > It mounts its root filesystem over nfs and has netconsole compiled
> > > > in.
> > > > 
> > > > Without the REGPARM option the system boots and runs fine.
> > > > 
> > > > Should I post the oopses, the result of ksymoops, a dmesg and kernel
> > > > config or is this an already known issue?
> > > 
> > > Not known. Please post the decoded oopses.  Also give your compiler
> > > version.
> > 
> > Hope this helps. The system runs fine with the option disabled.
> 
> Can you perhaps save your .config, do a make distclean and try
> to compile the kernel from scratch again? Maybe you had some stale object
> files around. 

Also, turn on kksymoops so that you'll get symbols in your oops reports, and
no need for ksymoops in userspace.
