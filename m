Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261725AbSJZA1g>; Fri, 25 Oct 2002 20:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSJZA1g>; Fri, 25 Oct 2002 20:27:36 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:12050
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261725AbSJZA1f>; Fri, 25 Oct 2002 20:27:35 -0400
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
From: Robert Love <rml@tech9.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
In-Reply-To: <3DB9DED0.5050809@pobox.com>
References: <F2DBA543B89AD51184B600508B68D4000EA1718C@fmsmsx103.fm.intel.com>
	<1035581420.734.3873.camel@phantasy> <20021026000137.GA19673@suse.de>
	<3DB9DC1D.3000807@pobox.com> <20021026001250.GA19948@suse.de> 
	<3DB9DED0.5050809@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 20:33:55 -0400
Message-Id: <1035592436.735.4361.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 20:16, Jeff Garzik wrote:


> That said, on IRC my preference was to create smp_num_siblings[] and 
> store the info per-cpu.  But right now that's only for software 
> engineering masturbation :) since it would store the same value N times 
> on current CPUs.

I agree with Jeff here - mostly because subverting the format is no
good, either.

In the future, or perhaps on other architectures, smp_num_siblings could
be per-processor.  So now we can extend this in the future and not break
the /proc interface.

Its just a by-product of the P4 that smp_num_siblings is global on
arch-i386.

	Robert Love


