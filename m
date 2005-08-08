Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753185AbVHHBIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbVHHBIb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 21:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbVHHBIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 21:08:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753185AbVHHBIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 21:08:30 -0400
Date: Sun, 7 Aug 2005 18:08:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH] abstract out bits of ldt.c
Message-ID: <20050808010828.GU7762@shell0.pdx.osdl.net>
References: <372830000.1123456808@[10.10.2.4]> <20050807234411.GE7991@shell0.pdx.osdl.net> <374910000.1123459025@[10.10.2.4]> <20050807174129.20c7202f.akpm@osdl.org> <20050808004645.GT7762@shell0.pdx.osdl.net> <42F6AF8E.60107@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F6AF8E.60107@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Does Xen assume page aligned descriptor tables?  I assume from this 

Yes.

> patch and snippets I have gathered from others, that is a yes, and other 
> things here imply that DT pages are not shadowed.  If so, Xen itself 
> must have live segments in the GDT pages, so how do you allocate space 
> for the per-CPU GDT pages on SMP?

early during boot.


> I think introducing mach-xen headers is a bit premature though - lets 
> get the interface nailed down first so that the hypervisor developers 
> have time to settle the include/asm-i386/mach-xxx files without dealing 
> unneeded churn onto the maintainers.

I don't think there's any point in putting mach-xen stuff in either.
Can we please discuss these patches in some sane way (say on the
virutalization list) so we're not cross-firing at each other.  It's just
going to be too messy otherwiswe.

thanks,
-chris
