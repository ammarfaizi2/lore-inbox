Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbSLVR0g>; Sun, 22 Dec 2002 12:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbSLVR0g>; Sun, 22 Dec 2002 12:26:36 -0500
Received: from franka.aracnet.com ([216.99.193.44]:61618 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265114AbSLVR0f>; Sun, 22 Dec 2002 12:26:35 -0500
Date: Sun, 22 Dec 2002 09:34:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Subject: Re: [PATCH][2.4]  generic support for systems with more than 8 CPUs
 (1/2)
Message-ID: <32680000.1040578470@titus>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E1B2@fmsmsx405.fm.intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E1B2@fmsmsx405.fm.intel.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1/2 : checking for xAPIC support in the system

OK, that looks pretty sane - one question:

> -		if ((clustered_apic_mode != CLUSTERED_APIC_XAPIC) &&
> +		if (!xapic_support &&
> +		    (clustered_apic_mode != CLUSTERED_APIC_XAPIC) &&

When does xapic_support differ from
(clustered_apic_mode == CLUSTERED_APIC_XAPIC) ?

Do you want to use a physical flat xapic mode for your stuff, or the
same clustered physical mode as the Summit stuff? If the latter, then
the new switch seems unnecessary ....

