Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbSLVWQh>; Sun, 22 Dec 2002 17:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSLVWQg>; Sun, 22 Dec 2002 17:16:36 -0500
Received: from holomorphy.com ([66.224.33.161]:61646 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265541AbSLVWQf>;
	Sun, 22 Dec 2002 17:16:35 -0500
Date: Sun, 22 Dec 2002 14:23:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Subject: Re: [PATCH][2.4]  generic support for systems with more than 8 CPUs (2/2)
Message-ID: <20021222222345.GJ9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
	Christoph Hellwig <hch@infradead.org>,
	James Cleverdon <jamesclv@us.ibm.com>,
	John Stultz <johnstul@us.ibm.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>,
	"Saxena, Sunil" <sunil.saxena@intel.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E1B3@fmsmsx405.fm.intel.com> <20021222121717.GH25000@holomorphy.com> <36680000.1040579247@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36680000.1040579247@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> IIRC NUMA-Q can be dynamically detected at boot by means of an MP OEM
>> table's presence, in particular if there's a matching string in the 8B
>> OEM record in the OEM table, with a value of "IBM NUMA" IIRC. This is
>> probably a line or two's worth of change to mpparse.c and declaring a
>> variable for clustered_apic_mode. If it were difficult to detect, I
>> wouldn't have suggested implementing it (though do so at your leisure). =)
>> I still think this is 2.5 material + backport once it gets testing there.

On Sun, Dec 22, 2002 at 09:47:28AM -0800, Martin J. Bligh wrote:
> I think there are still some things around that are switched on #defines
> for NUMA-Q. Also older machines will probably say Sequent instead of IBM
> in the OEM table. Would need some testing ...

Switching on #defines is easy to clean up; actually getting at the
older systems sounds like a PITA... OTOH OEM ID's are sort of too
simple to screw up aside from independent #defines that should be
visible issues on all systems. I'm not deeply concerned about this,
it merely appeared to dovetail into his goal of dynamic detection
and configuration of the APIC destination model. As far as we're
concerned, compile-time vs. runtime setup is probably not important.

Bill
