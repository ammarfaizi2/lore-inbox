Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbTICPMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbTICPMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:12:21 -0400
Received: from lidskialf.net ([62.3.233.115]:10368 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S262421AbTICPMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:12:20 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Stefan Smietanowski <stesmi@stesmi.com>,
       Vladimir Lazarenko <vlad@lazarenko.net>
Subject: Re: [ACPI] Where do I send APIC victims?
Date: Wed, 3 Sep 2003 17:10:49 +0100
User-Agent: KMail/1.5.3
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, rl@hellgate.ch,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <20030903080852.GA27649@k3.hellgate.ch> <200309031504.03596.vlad@lazarenko.net> <3F55F739.4010600@stesmi.com>
In-Reply-To: <3F55F739.4010600@stesmi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031710.49411.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>I can't back that. At least on all my Serverworks boxes there are no
> >>problems with ACPI. I got reports from VIA-bases SMP boards that they are
> >>doing well, too. (all for 2.4.22)
>
> And I can say that my Soyo SY-KT600 Ultra (VIA KT600+8237) has ACPI
> problems as well. pci=noacpi doesn't help but acpi=off does. It gives
> lots of errors that the ACPI tables are buggy when booting claiming
> my 8237 SATA controller has gotten IRQ -19 for instance.
> Using acpi=off solves the problem. This is with or without the libata
> VIA 8237 SATA driver. Without anything it recognizes the chip but
> doesn't like using IRQ -19 and doesn't see any disks. With pci=noacpi
> it sees the disks but bombs out when trying to get the partition table.
> It gets IRQ -19 still there. acpi=off makes it all work.

The IRQ -19 thing is a bug in my nforce2 patch in 2.4.22. It didn't drop back 
to using the PIC correctly. My latest acpi-picmode patch (posted to this list 
a few days back) corrects this, among other things.

