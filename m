Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbWJPK7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWJPK7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWJPK7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:59:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:26566 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030360AbWJPK7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:59:34 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 00/22] high resolution timers / dynamic ticks - V3
Date: Mon, 16 Oct 2006 12:53:49 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Dave Jones <davej@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
       Jim Gettys <jg@laptop.org>, Roman Zippel <zippel@linux-m68k.org>,
       akpm@osdl.org
References: <20061004172217.092570000@cruncher.tec.linutronix.de> <p73fye2zdjf.fsf@verdi.suse.de> <1160119688.3000.91.camel@laptopd505.fenrus.org>
In-Reply-To: <1160119688.3000.91.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161253.49969.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 09:28, Arjan van de Ven wrote:
> 
> > But usually the problem wasn't that it was too slow, but that
> > it completely stopped in C2 or deeper. I don't think there
> > is a way to work around that except for not using C2 or deeper
> > (not an option) or using a different timer source.
> 
> actually it's supposed to be C3 where lapic stops, not C2.

I've seen systems where it stopped in C2. The BIOS often 
mix these states up anyways and report C3 as a kind of C2
(with the cache flushing etc in SMM) and the other way round.
I think that's related to getting better performance on
Windows.

-Andi

