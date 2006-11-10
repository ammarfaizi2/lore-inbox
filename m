Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932836AbWKJKbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932836AbWKJKbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932837AbWKJKbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:31:16 -0500
Received: from ns2.suse.de ([195.135.220.15]:27787 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932836AbWKJKbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:31:15 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Date: Fri, 10 Nov 2006 11:30:51 +0100
User-Agent: KMail/1.9.5
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <200611100610.13957.ak@suse.de> <1163154519.3138.665.camel@laptopd505.fenrus.org>
In-Reply-To: <1163154519.3138.665.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101130.51528.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 11:28, Arjan van de Ven wrote:
> On Fri, 2006-11-10 at 06:10 +0100, Andi Kleen wrote:
> > Very sad. This will make a lot of people unhappy, even to the point
> > where they might prefer disabling noidlehz over super slow gettimeofday. 
> > I assume you at least have a suitable command line option for that, right?
> > 
> > Can we get a summary on which systems the TSC is considered unstable?
> 
> the part where it stops in idle...

That is handled by if (intel && C3 available) disable

-Andi
