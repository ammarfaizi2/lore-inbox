Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267035AbSLXCmm>; Mon, 23 Dec 2002 21:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267036AbSLXCmm>; Mon, 23 Dec 2002 21:42:42 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:52203 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267035AbSLXCml> convert rfc822-to-8bit; Mon, 23 Dec 2002 21:42:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH][2.4]  generic support for systems with more than 8 CP =?iso-8859-1?q?	Us?= (2/2)
Date: Mon, 23 Dec 2002 18:48:34 -0800
User-Agent: KMail/1.4.3
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       Christoph Hellwig <hch@infradead.org>,
       John Stultz <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <3FAD1088D4556046AEC48D80B47B478C1AEC76@usslc-exch-4.slc.unisys.com>
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C1AEC76@usslc-exch-4.slc.unisys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212231848.34915.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 December 2002 01:36 pm, Protasevich, Natalie wrote:
[ Snip! ]

>
> >In the last patch from Venkatesh there was a > 8CPUs option ... that
> >seems like a direct correlation to clustered apic support to me ...
> >maybe we could just switch on CONFIG_X86_CLUSTERED_APIC directly and
> >bypass CONFIG_X86_MANY_CPU? The menu text could stay the same (less
> >confusing for users than asking them about apic modes) ...
>
> Maybe, for other systems MANY_CPU criteria would make sense, but it won't
> work for us: on ES7000s with Fosters/Gallatins, we can run 1 to 32 CPUs and
> have to be in flat clustered mode in any case - whether we run 2 do 32 of

What is "flat clustered"?  Has Intel cooked up yet another APIC operating 
mode?   8^)   As far as I knew, the flat and clustered modes were mutually 
exclusive, based on the value in the DFR.

> them... This is also true for Cascades running on hierarchical cluster
> (logical). Our APIC ID's are hard-coded topologically in the BIOS, so we
> could run 2 processors on the high end of topology, with high APIC IDs. We
> couldn't get around using just ID's (not the EID's), because hardware needs
> the full CPU ID address to deliver IPIs.
>
> >M.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

