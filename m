Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVCYNhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVCYNhs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 08:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVCYNhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 08:37:48 -0500
Received: from poup.poupinou.org ([195.101.94.96]:18492 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S261621AbVCYNhi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 08:37:38 -0500
Date: Fri, 25 Mar 2005 14:37:24 +0100
To: Adam Belay <abelay@novell.com>
Cc: felix-linuxkernel@fefe.de, Andrew Morton <akpm@osdl.org>,
       cpufreq@ZenII.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino speedstep even more broken than in 2.6.10
Message-ID: <20050325133724.GZ2298@poupinou.org>
References: <20050311202122.GA13205@fefe.de> <20050311173517.7fe95918.akpm@osdl.org> <1110599659.12485.279.camel@localhost.localdomain> <20050321163225.4af1c169.akpm@osdl.org> <1111454454.6633.5.camel@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111454454.6633.5.camel@linux.site>
User-Agent: Mutt/1.5.6+20040907i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 08:20:55PM -0500, Adam Belay wrote:
> On Mon, 2005-03-21 at 19:32, Andrew Morton wrote:
> > Adam Belay <abelay@novell.com> wrote:
> > >
> > > On Fri, 2005-03-11 at 17:35 -0800, Andrew Morton wrote:
> > > > Felix von Leitner <felix-linuxkernel@fefe.de> wrote:
> > > > >
> > > > > Finally Centrino SpeedStep.
> > > > > I have a "Intel(R) Pentium(R) M processor 1.80GHz" in my notebook.
> > > > > Linux does not support it.  This architecture has been out there for
> > > > > months now, and there even was a patch to support it posted here a in
> > > > > October last year or so.  Linux still does not include it.  Until
> > > > > 2.6.11-rc4-bk8 or so, the old patched file from back then still worked.
> > > > > Now it doesn't.  Because some interface changed.  Now what?  Using a
> > > > > Centrino notebook without CPU throttling is completely out of the
> > > > > question.  Linux might as well not boot on it at all.
> > > > 
> > > > Could you please dig out the old patch, send it?
> > > 
> > > Why not use ACPI for CPU scaling?
> > > 
> > 
> > Felix, did you try this?
> > 
> 
> ACPI is the preferred (and only standardized) method of controlling cpu
> throttling on x86 systems.
> 

No.  ACPI is the preferred method in order to *get configuration*
for cpu frequency and voltage scaling, but it's up to a
specific processor driver to control frequency (actually I'm
simplifying things since it's possible to control frequency
from ACPI only, but only in certain situation).

Throttling is another method to frequency control by throttling
the processor (and ACPI is then preferred for both configuration
and controlling how to throttle the processor), but there is
no voltage scaling at all as for frequency and voltage scaling.

Those far it's up to the OP to activate ACPI even if he do not trust
ACPI.  It's the only way to get configuration from BIOS if he do not
want to hardcode a configuration in the speedstep-centrino driver.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
