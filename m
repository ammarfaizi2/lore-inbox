Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbSLWPWb>; Mon, 23 Dec 2002 10:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266717AbSLWPWb>; Mon, 23 Dec 2002 10:22:31 -0500
Received: from franka.aracnet.com ([216.99.193.44]:40628 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266540AbSLWPWa>; Mon, 23 Dec 2002 10:22:30 -0500
Date: Mon, 23 Dec 2002 07:30:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: "Kamble, Nitin A" <nitin.a.kamble@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>, Andi Kleen <ak@suse.de>,
       Hubert Mantel <mantel@suse.de>
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m ore than 8 CPUs
Message-ID: <441480000.1040657410@titus>
In-Reply-To: <Pine.LNX.4.50.0212230424340.1942-100000@montezuma.mastecende.com>
References: <E88224AA79D2744187E7854CA8D9131DA5CE37@fmsmsx407.fm.intel.com><83950000.1040629933@titus> <Pine.LNX.4.50.0212230424340.1942-100000@montezuma.mastecende.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about using logical destination mode when programming the IOAPIC?
> Currently we do physical in io_apic.c (the reason why it breaks on NUMAQ)
> This way we can get node affinity just by setting the Destination Field
> for an IOREDTBL to APIC_BROADCAST_ID and also targetting single cpus on a
> node becomes node generic.

Yup, that'll work fine once we have balance_IRQ set up with node affinity.
Using phys is just a cheapo lazy hacker's way to steal node affinity for
free from the mouths of babes.

M.

