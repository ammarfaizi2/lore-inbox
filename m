Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbVKGVNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVKGVNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVKGVNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:13:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:20361 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964943AbVKGVNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:13:34 -0500
Subject: Re: [PATCH 1/4] Memory Add Fixes for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
In-Reply-To: <20051107204743.GC5821@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com>
	 <20051104231800.GB25545@w-mikek2.ibm.com>
	 <1131149070.29195.41.camel@gaston> <20051107204743.GC5821@w-mikek2.ibm.com>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 08:12:56 +1100
Message-Id: <1131397976.4652.52.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just curious if we still want to boost MAX_ORDER like this with 64k
> pages?  Doesn't that make the MAX_ORDER block size 256MB in this case?
> Also, not quite sure what happens if memory size (a 16 MB multiple)
> does not align with a MAX_ORDER block size (a 256MB multiple in this
> case).  My 'guess' is that the page allocator would not use it as it
> would not fit within the buddy system.
> 
> cc'ing SPARSEMEM author Andy Whitcroft.

Yes, the MAX_ORDER should be different indeed. But can Kconfig do that ?
That is have the default value be different based on a Kconfig option ?
I don't see that ... We may have to do things differently here...

Ben.


