Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUDCPjt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 10:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUDCPjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 10:39:49 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:39365 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261804AbUDCPjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 10:39:48 -0500
Date: Sat, 3 Apr 2004 10:40:01 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6-mm] early_param console_setup clobbers commandline
In-Reply-To: <20040403030537.GF31152@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.58.0404031028090.11690@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0404022026560.11690@montezuma.fsmlabs.com>
 <20040403030537.GF31152@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2004, Tom Rini wrote:

> This shouldn't be a problem 'tho, since we don't allow for spaces in
> args, and we do find where the next space is, and ensure it's still a
> space after the call (because console can splice up the command line,
> but we'd skip over those bits anyhow).

Another new thing is that all setup functions get called with their
parameter and any other trailing arguments. So console_setup sees;

tty0 console=ttyS0,38400 hugepages=20 nmi_watchdog=2

That's different enough to cause potential problems in future.

> pci= will clobber as well, which is why I thought I asked Andrew to drop
> that part of the i386 patch (but perhaps I forgot, and with Rusty's
> patch, it becomes a non-issue again).

What is the patch name for Rusty's patch?
