Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264814AbSLVGcM>; Sun, 22 Dec 2002 01:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSLVGcM>; Sun, 22 Dec 2002 01:32:12 -0500
Received: from holomorphy.com ([66.224.33.161]:27084 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264814AbSLVGcL>;
	Sun, 22 Dec 2002 01:32:11 -0500
Date: Sat, 21 Dec 2002 22:39:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>, Andi Kleen <ak@suse.de>,
       Hubert Mantel <mantel@suse.de>,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Subject: Re: [PATCH][2.4]  generic cluster APIC support for systems with m ore than 8 CPUs
Message-ID: <20021222063926.GI9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
	Christoph Hellwig <hch@infradead.org>,
	James Cleverdon <jamesclv@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	John Stultz <johnstul@us.ibm.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>,
	"Saxena, Sunil" <sunil.saxena@intel.com>,
	"Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
	Andi Kleen <ak@suse.de>, Hubert Mantel <mantel@suse.de>,
	"Kamble, Nitin A" <nitin.a.kamble@intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E1B0@fmsmsx405.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E1B0@fmsmsx405.fm.intel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2002 at 10:19:20PM -0800, Pallipadi, Venkatesh wrote:
> I actually meant interrupt distribution (rather than interrupt
> routing). AFAIK, interrupt distribution right now assumes flat
> logical setup and tries to distribute the interrupt. And is disabled
> in case of clustered APIC mode. I was just thinking loud, about the
> changes interrupt distribution code should have for systems using
> clustered APIC/physical mode (NUMAQ and non-NUMAQ).

IIRC the physical DESTMOD in the IO-APIC's RTE's is not essential,
just somewhat more optimal given generalized node affinity. It also
dodged the need for infrastructure to associate various kinds of
devices with nodes in the 2.4.x timeframe.

Dumping small tidbits of decision-making and destination formatting
into headers that can be swizzled across subarches somehow would be ideal.


Thanks,
Bill
