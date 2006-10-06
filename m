Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbWJFH2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbWJFH2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 03:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbWJFH2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 03:28:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17130 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161091AbWJFH2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 03:28:17 -0400
Subject: Re: [patch 00/22] high resolution timers / dynamic ticks - V3
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Dave Jones <davej@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
       Jim Gettys <jg@laptop.org>, Roman Zippel <zippel@linux-m68k.org>,
       akpm@osdl.org
In-Reply-To: <p73fye2zdjf.fsf@verdi.suse.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
	 <20061005011608.b69e3461.akpm@osdl.org> <20061005081725.GA28877@elte.hu>
	 <p73fye2zdjf.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 06 Oct 2006 09:28:08 +0200
Message-Id: <1160119688.3000.91.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But usually the problem wasn't that it was too slow, but that
> it completely stopped in C2 or deeper. I don't think there
> is a way to work around that except for not using C2 or deeper
> (not an option) or using a different timer source.

actually it's supposed to be C3 where lapic stops, not C2.

For systems with C3, lapic is not usable for timers as is, and hpet or
similar needs to be used instead.


