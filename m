Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310271AbSCBCRn>; Fri, 1 Mar 2002 21:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310273AbSCBCRd>; Fri, 1 Mar 2002 21:17:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1806 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310271AbSCBCRV>; Fri, 1 Mar 2002 21:17:21 -0500
Subject: Re: 2.4.19pre1aa1
To: andrea@suse.de (Andrea Arcangeli)
Date: Sat, 2 Mar 2002 02:28:20 +0000 (GMT)
Cc: davidsen@tmr.com (Bill Davidsen), mfedyk@matchmail.com (Mike Fedyk),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020302030615.G4431@inspiron.random> from "Andrea Arcangeli" at Mar 02, 2002 03:06:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gzG0-0005qt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On a very lowmem machine the rmap design shouldn't really make a sensible
> difference, the smaller the amount of mapped VM, the less rmap can make
> differences, period.

It makes a big big difference on a low memory box. Try running xfce on
a 24Mb box with the base 2.4.18, 2.4.18 + rmap12f and 2.4.18+aa. Thats
a case where aa definitely loses and without other I/O patches being
applied. Its an X11 based workload with a -lot- of shared pages. Both
rmap and aa materially outperform 2.4.18 base on this workload (and 2.4.17
blew up with out of memory errors)

> IMHO vm-28 should be somehow included into mainline ASAP (before 2.4.19
> is released), then again IMHO we can forget about the 2.4 VM and it will
> be definitely finished.

With luck 8) VM is never finished 8(

Alan

