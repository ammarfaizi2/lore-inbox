Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbSLVMKN>; Sun, 22 Dec 2002 07:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbSLVMKN>; Sun, 22 Dec 2002 07:10:13 -0500
Received: from holomorphy.com ([66.224.33.161]:18893 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266356AbSLVMKM>;
	Sun, 22 Dec 2002 07:10:12 -0500
Date: Sun, 22 Dec 2002 04:17:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
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
Message-ID: <20021222121717.GH25000@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
	Christoph Hellwig <hch@infradead.org>,
	James Cleverdon <jamesclv@us.ibm.com>,
	John Stultz <johnstul@us.ibm.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>,
	"Saxena, Sunil" <sunil.saxena@intel.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E1B3@fmsmsx405.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E1B3@fmsmsx405.fm.intel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2002 at 10:59:10PM -0800, Pallipadi, Venkatesh wrote:
> 2/2 : switching to physical mode APIC setup in case of more than 8 CPU system
[...]
> -	printk("Enabling APIC mode: ");
> -	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
> -		printk("Clustered Logical.	");
> -	else if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
> -		printk("Physical.	");
> -	else
> -		printk("Flat.	");
> -	printk("Using %d I/O APICs\n",nr_ioapics);

IIRC NUMA-Q can be dynamically detected at boot by means of an MP OEM
table's presence, in particular if there's a matching string in the 8B
OEM record in the OEM table, with a value of "IBM NUMA" IIRC. This is
probably a line or two's worth of change to mpparse.c and declaring a
variable for clustered_apic_mode. If it were difficult to detect, I
wouldn't have suggested implementing it (though do so at your leisure). =)

I still think this is 2.5 material + backport once it gets testing there.


Bill
