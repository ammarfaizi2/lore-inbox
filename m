Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVHFMsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVHFMsy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 08:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVHFMsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 08:48:54 -0400
Received: from ozlabs.org ([203.10.76.45]:17818 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261813AbVHFMsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 08:48:50 -0400
Subject: Re: [PATCH, experimental] i386 Allow the fixmap to be relocated at
	boot time
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@osdl.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42F3FFBA.3040009@vmware.com>
References: <42F3F61F.30305@vmware.com>
	 <20050805234655.GY7762@shell0.pdx.osdl.net>  <42F3FFBA.3040009@vmware.com>
Content-Type: text/plain
Date: Sat, 06 Aug 2005 22:48:49 +1000
Message-Id: <1123332529.17152.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 17:09 -0700, Zachary Amsden wrote:
> Also, it seems reasonable that people may want to poke holes in high 
> linear space for other hypervisor projects, research, or performance 
> reasons without having to build a custom sub-architecture just for 
> that.  So I think there is some benefit to making the hole size a 
> general configurable option (with defaults depending on the sub-arch you 
> select).

qemu-fast needs a kernel with __FIXADDR_TOP 0xa7fff000, and PAGE_OFFSET
0x90000000.  I used to continually patch my kernels, but these days I
just run full qemu and take the speed hit.  If this was easier, it would
be really nice to have that speed back.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

