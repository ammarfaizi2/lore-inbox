Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273810AbRIXOXB>; Mon, 24 Sep 2001 10:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273867AbRIXOWu>; Mon, 24 Sep 2001 10:22:50 -0400
Received: from CPE-61-9-150-176.vic.bigpond.net.au ([61.9.150.176]:1270 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S273810AbRIXOWh>; Mon, 24 Sep 2001 10:22:37 -0400
Message-ID: <3BAF41AA.5014DF6E@eyal.emu.id.au>
Date: Tue, 25 Sep 2001 00:22:34 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10-pre15 -> final breaks IOAPIC on UP?
In-Reply-To: <E15lWVi-0002eV-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > So, I believe that any IOAPIC related change between 2.4.10-pre15 and
> > 2.4.10-final breaks my X11 here.
> 
> Uniprocessor IO-APIC only works for some machines. It also subtly changes
> IRQ delivery timing properties which may be worth checking too

I have an SMP machine (Epox D3VA, 2xPIII/933) which needs "noapic" boot
or it fails to read the "partition check" (lost interrupt). It is this
way since 2.4.8 and around 2.4.9-ac12 I checked and it had the same
problem. The problem is 100% reproducible.

I believe there are still some problems with apic even on SMP. Maybe
only on some mobos?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
