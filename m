Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261705AbSJZAFE>; Fri, 25 Oct 2002 20:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbSJZAFE>; Fri, 25 Oct 2002 20:05:04 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:58010 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261705AbSJZAFD>;
	Fri, 25 Oct 2002 20:05:03 -0400
Date: Sat, 26 Oct 2002 01:12:50 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Robert Love <rml@tech9.net>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
Message-ID: <20021026001250.GA19948@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>, Robert Love <rml@tech9.net>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"'akpm@digeo.com'" <akpm@digeo.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'chrisl@vmware.com'" <chrisl@vmware.com>,
	"'Martin J. Bligh'" <mbligh@aracnet.com>
References: <F2DBA543B89AD51184B600508B68D4000EA1718C@fmsmsx103.fm.intel.com> <1035581420.734.3873.camel@phantasy> <20021026000137.GA19673@suse.de> <3DB9DC1D.3000807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB9DC1D.3000807@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 08:04:45PM -0400, Jeff Garzik wrote:

 > Not really... we print out other information that is duplicated N times, 
 > because it is the common case that N-way systems have matched processors 
 > with matched capabilities.

Not really. We print out the 'duplicate' info because it's read that
way from different CPUs. The smp_num_siblings is a single global
variable. Theoretically, the other stuff /could/ change in an
asymetrical system, but the num_siblings thing is constant.
 
		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
