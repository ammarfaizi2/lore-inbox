Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267412AbSLRX5e>; Wed, 18 Dec 2002 18:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbSLRX5e>; Wed, 18 Dec 2002 18:57:34 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:36482 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267412AbSLRX5d>; Wed, 18 Dec 2002 18:57:33 -0500
Date: Wed, 18 Dec 2002 15:59:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Message-ID: <12670000.1040255953@flay>
In-Reply-To: <20021218232640.A1746@infradead.org>
References: <C8C38546F90ABF408A5961FC01FDBF1912E18E@fmsmsx405.fm.intel.com> <20021218232640.A1746@infradead.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
> +	if (clustered_apic_mode &&
> +		(configured_platform_type == CONFIGURED_PLATFORM_NUMA) ) {

Arrrggh - no. Let's not create even more of an unholy mess than is there 
already. The above is just vile.
 
> Except of that the patch looks fine, but IMHO something like that should
> get testing in 2.5 first.

Do it under subarch, in 2.5, and please wait until I merge the NUMA-Q
and Summit support that's working as is first. I'll send it out within
a week.

M.

PS. if people could change the email headers when replying to other 
branches of  this thread from mbligh@us.ibm.com to mbligh@aracnet.com,
I'd much appreciate it.
