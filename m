Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274145AbRIXSkM>; Mon, 24 Sep 2001 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274146AbRIXSkA>; Mon, 24 Sep 2001 14:40:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60516 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S274145AbRIXSju>; Mon, 24 Sep 2001 14:39:50 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        linux-kernel@vger.kernel.org (Linux-Kernel mailing list),
        mingo@redhat.com
Subject: Re: 2.4.10-pre15 -> final breaks IOAPIC on UP?
In-Reply-To: <E15lWVi-0002eV-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Sep 2001 12:30:56 -0600
In-Reply-To: <E15lWVi-0002eV-00@the-village.bc.nu>
Message-ID: <m1ofo07867.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > So, I believe that any IOAPIC related change between 2.4.10-pre15 and
> > 2.4.10-final breaks my X11 here.
> 
> Uniprocessor IO-APIC only works for some machines. It also subtly changes
> IRQ delivery timing properties which may be worth checking too

All athlon motherboards with the via686 southbridge and an AMD northbridge
should fail according to the AMD errata.  This may also happen with a via
northbridge.  The AMD apic bus is subtely different from the intel apic
bus in implementation.

Eric
