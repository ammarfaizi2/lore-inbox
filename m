Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932840AbWKJKhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbWKJKhM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932842AbWKJKhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:37:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4490 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932837AbWKJKhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:37:10 -0500
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <200611101130.51528.ak@suse.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <200611100610.13957.ak@suse.de>
	 <1163154519.3138.665.camel@laptopd505.fenrus.org>
	 <200611101130.51528.ak@suse.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 11:37:05 +0100
Message-Id: <1163155026.3138.673.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 11:30 +0100, Andi Kleen wrote:
> On Friday 10 November 2006 11:28, Arjan van de Ven wrote:
> > On Fri, 2006-11-10 at 06:10 +0100, Andi Kleen wrote:
> > > Very sad. This will make a lot of people unhappy, even to the point
> > > where they might prefer disabling noidlehz over super slow gettimeofday. 
> > > I assume you at least have a suitable command line option for that, right?
> > > 
> > > Can we get a summary on which systems the TSC is considered unstable?
> > 
> > the part where it stops in idle...
> 
> That is handled by if (intel && C3 available) disable

I'm not so sure it doesn't stop on AMD; the ACPI spec at least allows
it; just that I've seen few AMD CPUs that actually have C3, but that
could be a matter of time.


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

