Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWEZH6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWEZH6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWEZH6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:58:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:11219 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750821AbWEZH6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:58:52 -0400
From: Andi Kleen <ak@suse.de>
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH 1/4] x86-64: Calgary IOMMU - introduce iommu_detected
Date: Fri, 26 May 2006 09:54:16 +0200
User-Agent: KMail/1.9.1
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
References: <20060525033408.GC7720@us.ibm.com> <200605250554.23534.ak@suse.de> <20060526044636.GA31695@us.ibm.com>
In-Reply-To: <20060526044636.GA31695@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605260954.17140.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also, in the reworked version of iommu-abstraction on
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches has a bug.  When
> iommu_setup was kept in it's original form, the "+__setup("iommu=",
> iommu_setup);" wasn't removed, which gives 2 calls to the same function.
> I'll send updated versions of the patches here shortly which will apply
> cleanly inplace to that tree.

That was intentional. All early boot options need a __setup too, otherwise
they will appear as variables in init's environment.

It would be only a problem if the code couldn't run twice, but that is 
normally not the case.

-Andi
