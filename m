Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSJZAbs>; Fri, 25 Oct 2002 20:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSJZAbs>; Fri, 25 Oct 2002 20:31:48 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:21778
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261733AbSJZAbs>; Fri, 25 Oct 2002 20:31:48 -0400
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
From: Robert Love <rml@tech9.net>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Daniel Phillips <phillips@arcor.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
In-Reply-To: <3DB9D789.4020101@sktc.net>
References: <F2DBA543B89AD51184B600508B68D4000ECE7086@fmsmsx103.fm.intel.com>	<3DB9CC5D.
	 7000600@pobox.com>  <3DB9D1FE.5010607@sktc.net>
	<1035588310.734.4165.camel@phantasy>  <3DB9D789.4020101@sktc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 20:37:57 -0400
Message-Id: <1035592677.734.4377.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 19:45, David D. Hagood wrote:

> I would assert that, at least in the case of the P4, there IS a "major 
> core", as the 2 subcores share L1 and bus controller access, as well as 
> several other parts of the chip.
> 
> I beleive this is to some extent the case in the Power4 modules - that 
> each module contains resources shared by the execution units. However, I 
> might be full of it, and since there are plenty of @ibm.com's here I 
> expect to be corrected shortly....

You are entirely right :)

But argument for siblings vs. subcore is that in the context of the
processors displayed in /proc/cpuinfo known of them are "subscores" of
the other (and thus none of them are the "main core").

Some are just "siblings" in the same parent process package.  So given a
dual Xeon machine, you have 4 virtual processors, which are broken into
two sets of two siblings.  Those two sets are each part of the same
package.

	Robert Love

