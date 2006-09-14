Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWINIdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWINIdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 04:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWINIdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 04:33:24 -0400
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:25267 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S1751283AbWINIdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 04:33:23 -0400
From: Thomas Richter <thor@mail.math.tu-berlin.de>
Message-Id: <200609140833.k8E8XDWQ013712@mersenne.math.TU-Berlin.DE>
Subject: Re: MSI K9N Neo: crash under heavy IDE read
In-Reply-To: <200609121818.44766.vda.linux@googlemail.com>
To: Denis Vlasenko <vda.linux@googlemail.com>
Date: Thu, 14 Sep 2006 10:33:13 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL108 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I bought new Athlon46 mobo with AM2 socket and recently
> > I noticed that copying large amounts of data reliably
> > crashes 2.6.17.11 64-bit on it.
> > 
> > memtest runs ok on this machine overnight.
> > Machine is not overclocked.
> > 
> > Copying movies from SATA drive to PATA drive oopses
> > after few gigabytes transferred. Creating iso image
> > with mkisofs (done entirely on PATA drive, no SATA attached)
> > does the same.
> > 
> > After some testing I found ou that rw load crashes
> > machine rather fast, while read load usually runs for several
> > minutes before crash. Setting udma4 or udma3 instead of udma5
> > doesn't help. Pity I don't have my own SATA drive to run tests
> > with it, ran most of the tests on PATA drive.
> 
> I obtained PCI config space dumps under Windows XP on this machine
> and compared them to Linux settings. Integrated PATA IDE controller
> has some differences in rows 5x and 8x. Grep for "IDE interface".
> 
> Maybe this sheds some light.
> 
> URLs to chipset docs, anyone?...

Not really, but allow me to make another comment: MSI seems to have
massive problems with the K9N based boards. A good percentage of them
just "freaks out" from time to time and shuts the system down with no
aparent reason. This happens under Linux as well as under windows, and
is, interestingly, related to copying large amounts of data to the
PATA controller, and transfering large amounts of data over the LAN
causes the same problem. It thus would be interesting to know whether
for the affected board the same or a similar problem appears under
win32. If so, it's just the defective board, and not a linux kernel
problem.

Reference for the problem: Look into the MSI forum at www.msi.com, 
check for the thread "Post your K9N problems here...".

So long,
	Thomas


