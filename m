Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267998AbUHPWcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUHPWcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267996AbUHPWcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:32:02 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:54687 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267992AbUHPWbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:31:50 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] HPT374 kernel panic - regression in 2.6.8
Date: Tue, 17 Aug 2004 00:30:45 +0200
User-Agent: KMail/1.6.2
Cc: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <411DF42E.5030504@kmlinux.fjfi.cvut.cz> <1092496584.27144.3.camel@localhost.localdomain>
In-Reply-To: <1092496584.27144.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408170030.45553.bzolnier@elka.pw.edu.pl>
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 August 2004 17:16, Alan Cox wrote:
> On Sad, 2004-08-14 at 12:14, Jindrich Makovicka wrote:
> > Hello,
> >
> > HighPoint 374 driver in 2.6.8 can cause kernel panic on boot with
> > non-33MHz timings because some lines from an older version have been
> > included in the source again. After removing the check, HPT374 works
> > just fine using internal PLL.
>
> The HPT374 only supports 33Mhz timings. If you are overclocking it then
> its probably going to mostly work. The lines added are not "from an
> older source file" but form a port forwards of long missing and
> important fixes from 2.4 that have been there for a long long time.

2.4 driver also misses some fixes...

> So the first question is why does your late series HPT37x think its
> running at > 33Mhz ? Are you overclocking it ?

http://linus.bkbits.net:8080/linux-2.5/cset@40586b50zsHhQgPLGTlje7g_f5wGTw?nav=index.html|
src/|src/drivers|src/drivers/ide|src/drivers/ide/pci|
related/drivers/ide/pci/hpt366.c

please read bugzilla bugs mentioned in the changelong and fix this
