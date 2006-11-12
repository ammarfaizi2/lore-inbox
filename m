Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753089AbWKLUcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbWKLUcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 15:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbWKLUcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 15:32:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26593 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753083AbWKLUcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 15:32:46 -0500
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
In-Reply-To: <200611122019.09851.ioe-lkml@rameria.de>
References: <200611111129.kABBTWgp014081@fire-2.osdl.org>
	 <20061112125357.GH25057@stusta.de>
	 <1163337376.3293.120.camel@laptopd505.fenrus.org>
	 <200611122019.09851.ioe-lkml@rameria.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 12 Nov 2006 21:32:36 +0100
Message-Id: <1163363556.15249.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-12 at 20:18 +0100, Ingo Oeser wrote:
> Hi there,
> 
> On Sunday, 12. November 2006 14:16, Arjan van de Ven wrote:
> > If this isn't UP this could be the first real case of "noapic" in your
> > entire list...... which isn't too useful. 
> > Maybe we need to get more/any people who see "need noapic on SMP" to
> > file a bug (and provide a reasonable amount of info)
> 
> I need noapic since ever (5 years!) to get my USB controller running.
> Without noapic it doesn't get any interrupts for some reason.

so it never worked? (that's important to know versus regression)

Also does this machine use ACPI for interrupt routing?
That's also important, because if you're NOT using ACPI, "noapic" means
that you're using the PIRQ for irq routing and not MPS, so you're not
"just" changing apic behavior, you're actually using a different BIOS
table. (and to be honest, a buggy bios table is more likely the
cause ... ;)



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

