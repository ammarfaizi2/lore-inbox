Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbTHYK4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbTHYK4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:56:11 -0400
Received: from ns.suse.de ([195.135.220.2]:43736 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261621AbTHYK4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:56:07 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: paul.devriendt@amd.com, davej@redhat.com, linux-kernel@vger.kernel.org,
       aj@suse.de, richard.brunner@amd.com, mark.langsdorf@amd.com
Subject: Re: Cpufreq for opteron
References: <99F2150714F93F448942F9A9F112634C080EF006@txexmtae.amd.com.suse.lists.linux.kernel>
	<20030825084616.GC403@elf.ucw.cz.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 25 Aug 2003 12:56:04 +0200
In-Reply-To: <20030825084616.GC403@elf.ucw.cz.suse.lists.linux.kernel>
Message-ID: <p7365km57ln.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Okay, but hopefully machines being sold in retail will have bug-free
> BIOSes?

That was a good one.

BIOS are _always_ buggy.

Especially on production boards, when someone far away butchered a BIOS
until it booted XP instead of knowing what he was doing.

> > I know the debug code is ugly ... but, I am expecting to need it. In the
> > next rev of the driver, when hardware is publicly for sale, we have some
> > degree of stability, etc ... then great. But, for now, releasing a driver
> > that has only been tested on prototype hardware ... and removing the
> > debug code. Ouch.
> 
> If we want the code to be in 2.6.X final, it is good to start pushing
> it _now_. And we can't reasonably expect linus to eat patch with
> _that_ much debugging.

I don't see the problem, as long as the debugging code is a bit cleaned
up (no ifdefs in the functions itself). Also we have precendence
in some other subsystem that come with extensive debugging code.
Code ugliness comes from other things, not debugging code.

I think Paul's point - anything dependent on the BIOS should have a
a lot of self diagnosis support because BIOS are usually buggy - makes
a lot of sense. Otherwise one will have to add printks again 
as needed, and that would be a waste of time.

-Andi
