Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSLYVfz>; Wed, 25 Dec 2002 16:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbSLYVfz>; Wed, 25 Dec 2002 16:35:55 -0500
Received: from m83-mp1.cvx2-c.ren.dial.ntli.net ([62.252.152.83]:41973 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S261346AbSLYVfz>; Wed, 25 Dec 2002 16:35:55 -0500
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m
	ore than 8 CPUs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Cleverdon'" <jamesclv@us.ibm.com>,
       "'Pallipadi, Venkatesh'" <venkatesh.pallipadi@intel.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Martin Bligh'" <mbligh@us.ibm.com>,
       "'John Stultz'" <johnstul@us.ibm.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "'Mallick, Asit K'" <asit.k.mallick@intel.com>,
       "'Saxena, Sunil'" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       "'Andi Kleen'" <ak@suse.de>, "'Hubert Mantel'" <mantel@suse.de>
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C1AEC73@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C1AEC73@usslc-exch-4.slc.unisys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Dec 2002 21:41:56 +0000
Message-Id: <1040852516.1109.33.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing I will say. Your code would be a hell of a lot saner for
merging if you mapped the ISA/Legacy IRQ's as 0-15 (to software) and the
PCI ones to 16+ like everyone else does. That would kill a _lot_ of
ifdefs and the IRQ0 corner case


