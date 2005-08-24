Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVHXV3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVHXV3D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVHXV3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:29:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39140 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932258AbVHXV3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:29:02 -0400
Date: Wed, 24 Aug 2005 14:28:37 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>
Subject: Re: [PATCH 5/5] Create a hole in high linear address space
Message-ID: <20050824212837.GP7762@shell0.pdx.osdl.net>
References: <200508241845.j7OIjIeM001900@zach-dev.vmware.com> <20050824201920.GN7762@shell0.pdx.osdl.net> <430CE428.3000605@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430CE428.3000605@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Hmm.  I was thinking it would be compile time variable with defaults -- like
> 
> config MEMORY_HOLE
>       int "Create hole at top of memory (0-512 MB)"
>       range 0 512
>       default "0"
>       default 168 if (CONFIG_X86_PAE && CONFIG_X86_HYPERVISOR)
>       default 64 if (!CONFIG_X86_PAE && CONFIG_X86_HYPERVISOR)

That's fine, I had done some braindead math anyway ;-)

>       help
>          Useful for creating a hole in the top of memory when running
>          inside of a virtual machine monitor.
> 
> Adding things to the fixmap is a separate concept, thus a separate patch ;)

Sure, good point.

thanks,
-chris
