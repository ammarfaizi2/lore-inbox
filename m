Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVDZNx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVDZNx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVDZNx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:53:26 -0400
Received: from cantor2.suse.de ([195.135.220.15]:55987 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261520AbVDZNxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:53:14 -0400
Date: Tue, 26 Apr 2005 15:53:12 +0200
From: Andi Kleen <ak@suse.de>
To: Patrick McHardy <kaber@trash.net>
Cc: Andi Kleen <ak@suse.de>, Ed Tomlinson <tomlins@cam.org>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
Message-ID: <20050426135312.GI5098@wotan.suse.de>
References: <200504240008.35435.kernel-stuff@comcast.net> <1114332119.916.1.camel@localhost.localdomain> <200504240903.31377.tomlins@cam.org> <426CADF1.2000100@trash.net> <20050425153541.GC16828@wotan.suse.de> <426E3C6F.6010001@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426E3C6F.6010001@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 03:04:47PM +0200, Patrick McHardy wrote:
> Andi Kleen wrote:
> >Well, you can revert all my x86-64 changes for testing that went
> >in after rc2. Does that make a difference? If yes then please
> >do a binary search or give me a test case that shows the problem.
> 
> It's this one:
> 
> [PATCH] x86_64: Fix a small missing schedule race
> 
> Uml seems to be a good testcase, the box reliably reboots while uml
> is starting up, usually shortly after the root-filesystem has been
> mounted.

Hmm, thats hard to believe. And are you sure the NMI watchdog
did not trigger? (e.g. did you run it with serial or netconsole)?

-Andi
