Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265710AbSKATJN>; Fri, 1 Nov 2002 14:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265712AbSKATJM>; Fri, 1 Nov 2002 14:09:12 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:45953 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265710AbSKATI6>;
	Fri, 1 Nov 2002 14:08:58 -0500
Date: Fri, 1 Nov 2002 19:14:40 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "'torvalds@transmeta.com'" <torvalds@transmeta.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [PATCH] 2.5.45 - i386 MCA update
Message-ID: <20021101191440.GA31669@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	"'torvalds@transmeta.com'" <torvalds@transmeta.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>
References: <10C8636AE359D4119118009027AE99871E606C42@fmsmsx34.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10C8636AE359D4119118009027AE99871E606C42@fmsmsx34.fm.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 11:02:55AM -0800, Pallipadi, Venkatesh wrote:
 > Hi,
 > 
 >    Attached is the patch with few i386 MCA updates. Summary of changes:
 > - Logging of corrected (non critical) MCA errors on P4.
 > - Don't clear the MCA status info. in case of a non-recoverable error. If OS
 > has failed in logging those, 
 >   BIOS can still have a look at that info.
 > - Minor bug fix in do_mce_timer(). Check current cpu registers too, while
 > calling smp_call_function().

I've a lot of pending patches to bluesmoke (splitting it all up
into per-vendor files). This patch will make that a real PITA to
rework. Can you take a look at the work in 2.5-ac and diff against
that instead ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
