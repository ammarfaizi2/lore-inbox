Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbSLVWTU>; Sun, 22 Dec 2002 17:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbSLVWTU>; Sun, 22 Dec 2002 17:19:20 -0500
Received: from holomorphy.com ([66.224.33.161]:63694 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265480AbSLVWTS>;
	Sun, 22 Dec 2002 17:19:18 -0500
Date: Sun, 22 Dec 2002 14:26:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4]  generic support for systems with more than 8 CP	Us (2/2)
Message-ID: <20021222222623.GK9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
	Christoph Hellwig <hch@infradead.org>,
	James Cleverdon <jamesclv@us.ibm.com>,
	John Stultz <johnstul@us.ibm.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>,
	"Saxena, Sunil" <sunil.saxena@intel.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <3FAD1088D4556046AEC48D80B47B478C1AEC74@usslc-exch-4.slc.unisys.com> <8870000.1040590913@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8870000.1040590913@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
> >>IIRC NUMA-Q can be dynamically detected at boot by means of an MP OEM
> >>table's presence, in particular if there's a matching string in the 8B
> >>OEM record in the OEM table, with a value of "IBM NUMA" IIRC. This is
> >>probably a line or two's worth of change to mpparse.c and declaring a
> >>variable for clustered_apic_mode. If it were difficult to detect, I
> >>wouldn't have suggested implementing it (though do so at your leisure).
> >>=)

On Sun, Dec 22, 2002 at 01:01:54PM -0800, Martin J. Bligh wrote:
> I don't think you need the OEM table to detect this, current patches do:
> 
> +static inline void mps_oem_check(struct mp_config_table *mpc, char *oem,
> +               char *productid)
> +{
> +       if (strncmp(oem, "IBM NUMA", 8))
> +               printk("Warning!  May not be a NUMA-Q system!\n");

Well, this is precisely what I meant by checking the OEM ID. It appears
to already be implemented in at least one set of patches, then. =)

Cheers,
Bill
