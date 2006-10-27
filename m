Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946248AbWJ0I1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946248AbWJ0I1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 04:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946247AbWJ0I1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 04:27:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16052 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946248AbWJ0I1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 04:27:33 -0400
Date: Fri, 27 Oct 2006 10:27:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC: 2.6.19 patch] let PCI_MULTITHREAD_PROBE depend on BROKEN
Message-ID: <20061027082726.GA1880@elf.ucw.cz>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de> <20061027012058.GH5591@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027012058.GH5591@parisc-linux.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-10-26 19:20:58, Matthew Wilcox wrote:
> On Fri, Oct 27, 2006 at 03:02:52AM +0200, Adrian Bunk wrote:
> > PCI_MULTITHREAD_PROBE is an interesting feature, but in it's current 
> > state it seems to be more of a trap for users who accidentally
> > enable it.
> > 
> > This patch lets PCI_MULTITHREAD_PROBE depend on BROKEN for 2.6.19.
> > 
> > The intention is to get this patch reversed in -mm as soon as it's in 
> > Linus' tree, and reverse it for 2.6.20 or 2.6.21 after the fallout of 
> > in-kernel problems PCI_MULTITHREAD_PROBE causes got fixed.
> 
> People who enable features clearly marked as EXPERIMENTAL deserve what
> they get, IMO.

Eh? It is no longer "experimental". It went to "known broken in
non-funny ways".

People normally use experimental features... (like cpu hotplug, acpi
hotkeys, intel 830m framebuffer, USB CATC ethernet, SDHCI, kernel
profiling) without expecting breakages. (Hmm, perhaps some of these
should not be marked experimental any more?)

I'd actually vote for removing MULTITHREAD_PROBE from kconfig,
temporarily, but I guess BROKEN is okay, too.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
