Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946511AbWKJL4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946511AbWKJL4w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 06:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946513AbWKJL4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 06:56:52 -0500
Received: from mail.suse.de ([195.135.220.2]:58516 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946512AbWKJL4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 06:56:51 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Date: Fri, 10 Nov 2006 12:56:35 +0100
User-Agent: KMail/1.9.5
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061110111231.GB3291@elf.ucw.cz> <20061110114806.GA6780@elte.hu>
In-Reply-To: <20061110114806.GA6780@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611101256.35306.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> we could, but it would have to be almost empty right now :-) Reason: 
> even on systems that have (hardware-initialized) 'perfect' TSCs and 
> which do not support any frequency scaling or power-saving mode, our 
> current TSC initialization on SMP systems introduces a small (1-2 usecs) 
> skew.

On Intel we don't sync the TSC anymore and on most systems users seem
to be happy at least. And on multicore AMD it is drifting anyways and 
usually turned off.

-Andi
