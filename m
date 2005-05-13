Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVEMN1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVEMN1G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 09:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVEMN1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 09:27:06 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:13072 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262359AbVEMN1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 09:27:03 -0400
Message-ID: <4284AAFE.6070609@shadowen.org>
Date: Fri, 13 May 2005 14:26:22 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, Martin Bligh <mbligh@aracnet.com>
Subject: Re: [-mm patch] mm.h: fix page_zone compile error
References: <20050512033100.017958f6.akpm@osdl.org> <20050512214258.GC3603@stusta.de>
In-Reply-To: <20050512214258.GC3603@stusta.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:

>   CC      mm/hugetlb.o
> mm/hugetlb.c: In function `enqueue_huge_page':
> include/linux/mm.h:500: sorry, unimplemented: inlining failed in call to 
> 'page_zone': function not considered for inlining
> mm/hugetlb.c:486: sorry, unimplemented: called from here
> make[1]: *** [mm/hugetlb.o] Error 1
> make: *** [mm] Error 2

Interesting.  I assume that this implies that older versions may not be
inlining this even though we have asked them to.  I'll go confirm there
is no adverse effects from patch.

-apw
