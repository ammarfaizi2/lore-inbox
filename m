Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946249AbWKJKLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946249AbWKJKLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946254AbWKJKLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:11:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8064 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946249AbWKJKLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:11:15 -0500
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20061110085728.GA14620@elte.hu>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233035.569684000@cruncher.tec.linutronix.de>
	 <1163121045.836.69.camel@localhost> <200611100610.13957.ak@suse.de>
	 <1163146206.8335.183.camel@localhost.localdomain>
	 <20061110005020.4538e095.akpm@osdl.org>  <20061110085728.GA14620@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Nov 2006 10:14:30 +0000
Message-Id: <1163153670.7900.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-11-10 am 09:57 +0100, ysgrifennodd Ingo Molnar:
> AFAIK Windows doesnt use it, so it's a continuous minefield for new 
> hardware to break.

Windows uses it extensively especially games. The AMD desync upset a lot
of Windows gamers.

> We should wait until CPU makers get their act together and implement a 
> TSC variant that is /architecturally promised/ to have constant 
> frequency (system bus frequency or whatever) and which never stops.

This will never happen for the really big boxes, light is just too
slow... Our current TSC handling is not perfect but the TSC is often
quite usable.

If hrtimer needs and requires we stop TSC support then we should delay
the merge of HRTIMERS until these new processors are out and common ;)

Alan

