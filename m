Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbUCDPcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 10:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbUCDPcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 10:32:10 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:19644 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261936AbUCDPbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 10:31:50 -0500
Date: Thu, 4 Mar 2004 08:31:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Greg Weeks <greg.weeks@timesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH} PPC 32 multithreaded core dumps
Message-ID: <20040304153149.GD26065@smtp.west.cox.net>
References: <403D04D4.3020502@timesys.com> <20040225211353.GD1052@smtp.west.cox.net> <404729AC.8010405@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404729AC.8010405@timesys.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 08:05:48AM -0500, Greg Weeks wrote:

> Tom Rini wrote:
> 
> >On Wed, Feb 25, 2004 at 03:25:56PM -0500, Greg Weeks wrote:
> >
> >>This code fixes the register dumps for 32 bit ppc multi threaded core 
> >>dumps. It's largely based on the ppc64 code. It was tested on an 8260 
> >
> >This looks right, and I'll think about it a bit more and apply.
> >
> >>processor with the TimeSys modified 2.6.1 kernel. The patch is for 
> >>2.6.3. Let me know if there are any problems with it. If anyone can tell 
> >>me why arch/ppc/boot/simple/misc.c was including elf.h in the first 
> >>place I'd appreciate it. It doesn't appear to need it and it doesn't 
> >>like task_struct now.
> >
> >Long ago it used to care more about the file it was dealing with.  I'll
> >remove it from the other files in boot/ that include it as well.
>
> How does this still look?

I removed the #include as part of a greater fixing up of arch/ppc/boot,
that I'll hopefully get to Linus for the next release.   I'll throw the
multithreaded coredump patch in as well then.

-- 
Tom Rini
http://gate.crashing.org/~trini/
