Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269664AbTHFP4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 11:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269671AbTHFP4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 11:56:20 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:20949 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S269664AbTHFP4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 11:56:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16177.9504.20997.655595@gargle.gargle.HOWL>
Date: Wed, 6 Aug 2003 17:56:16 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Brown, Len" <len.brown@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.0-test2 on Dell PE2650, ACPI_HT_ONLY strangeness
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC08@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC08@hdsmsx402.hd.intel.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len writes:
 > You're right.
 > 
 > This was an ill-fated attempt at backwards compatibility.
 > I removed acpismp=force in an ACPI cleanup a short time ago, and it
 > should
 > hit the tree via the ACPI maintainer after Andy returns from vacation.

Great! Thanks.

/Mikael

 > 
 > Cheers,
 > -Len
 > 
 > > -----Original Message-----
 > > From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 
 > > Sent: Wednesday, August 06, 2003 10:40 AM
 > > To: linux-kernel@vger.kernel.org
 > > Subject: 2.6.0-test2 on Dell PE2650, ACPI_HT_ONLY strangeness
 > > 
 > > 
 > > Before upgrading our PowerEdge 2650 (dual HT Xeons, Tigon3,
 > > aic7899, workspace on sw raid5 over 4 disks, ext3) to RH9,
 > > I gave 2.6.0-test2 a spin. Worked fine, except for one thing.
 > > 
 > > In 2.4, CONFIG_SMP automatically uses acpitable.c to detect
 > > secondary threads via the MADT (since MPS doesn't handle them).
 > > 
 > > In 2.6.0-test2, with CONFIG_SMP and CONFIG_ACPI_HT_ONLY, this
 > > doesn't happen, _unless_ I also pass acpismp=force on the command
 > > line. Without acpismp=force, it only finds two CPUs.
 > > 
 > > The logic in arch/i386/kernel/setup.c, which defaults acpi to
 > > disabled if HT_ONLY is chosen, seems backwards. Surely if I
 > > configure HT_ONLY it's because I want to use it, no?
 > > 
 > > /Mikael
 > > -
 > > To unsubscribe from this list: send the line "unsubscribe 
 > > linux-kernel" in
 > > the body of a message to majordomo@vger.kernel.org
 > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > > Please read the FAQ at  http://www.tux.org/lkml/
 > > 
