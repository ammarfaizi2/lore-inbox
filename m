Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754840AbWKKN7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbWKKN7L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 08:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbWKKN7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 08:59:11 -0500
Received: from mail.suse.de ([195.135.220.2]:56284 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754840AbWKKN7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 08:59:10 -0500
From: Andi Kleen <ak@suse.de>
To: tglx@linutronix.de
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Date: Sat, 11 Nov 2006 14:59:05 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <200611111451.33511.ak@suse.de> <1163253488.8335.247.camel@localhost.localdomain>
In-Reply-To: <1163253488.8335.247.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611111459.05854.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 November 2006 14:58, Thomas Gleixner wrote:

> > 
> > > > My guess is that some of the checks in there are just broken and need
> > > > to be fixed.
> > > 
> > > It's the unconditional mark_unstable call in ACPI C2 state. /me looks.
> > 
> > The system doesn't support C2 states. It's an older single socket Athlon 64 
> > with VIA chipset. I haven't looked in detail on why it fails.
> 
> Does it have cpu freqency changing ?

Yep. But only OS controlled one (powernow).

Most likely it happens when ondemand starts doing its thing.

-Andi
