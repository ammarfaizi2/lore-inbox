Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932789AbWCQVMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbWCQVMo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 16:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWCQVMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 16:12:43 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:1408 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932789AbWCQVMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 16:12:42 -0500
Date: Fri, 17 Mar 2006 13:11:46 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Joshua LeVasseur <jtl@ira.uka.de>
Cc: Pavel Machek <pavel@ucw.cz>, Zachary Amsden <zach@vmware.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
Message-ID: <20060317211146.GP15997@sorel.sous-sol.org>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <20060315230012.GA1919@elf.ucw.cz> <869E58AF-339F-4660-8458-36F58A5E35EF@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <869E58AF-339F-4660-8458-36F58A5E35EF@ira.uka.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Joshua LeVasseur (jtl@ira.uka.de) wrote:
> extern "C" void
> afterburn_cpu_write_gdt32_ext( burn_clobbers_frame_t *frame )
> {
>     get_cpu()->gdtr =  *(dtr_t *)frame->eax;
> }

What is this get_cpu()?  Accessing data structure that's avail. in ROM
and shared with hypervisor...could you elaborate a bit here?

thanks,
-chris
