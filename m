Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWCVXCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWCVXCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWCVXCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:02:34 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:4483 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750969AbWCVXCc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:02:32 -0500
Date: Wed, 22 Mar 2006 15:02:17 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Daniel Arai <arai@vmware.com>
Cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
Message-ID: <20060322230217.GN15997@sorel.sous-sol.org>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org> <4421CCA8.4080702@vmware.com> <4421D0C9.6080603@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4421D0C9.6080603@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Arai (arai@vmware.com) wrote:
> To elaborate a bit more, the "ROM" layer is "published" by the hypervisor.  
> This layer of abstraction will let you take a VMI-compiled kernel and run 
> it efficiently on any hypervisor that exports a VMI interface - even one 
> that you didn't know about (or didn't exist) when you compiled your kernel.
> 
> If the ROM part is compiled into the code, then you have to compile in 
> support for the specific hypervisor(s) you want to run on.  It might be 
> reasonable for this code to be in a lodable kernel module, rather than a 
> device ROM per se, but you still want that kernel module to be provided by 
> the hypervisor.

I don't agree.  That module may know how to get interface info from a
vdso analog (just like a driver knows the hardware details of the device
it's interacting with, but the core kernel api is unaware), but placing
the binary compatibility on the kernel proper is wrong IMO.

thanks,
-chris
