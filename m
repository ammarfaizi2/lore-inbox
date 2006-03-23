Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWCWBB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWCWBB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWCWBB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:01:27 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:33553 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932152AbWCWBB0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:01:26 -0500
Message-ID: <4421F34F.6030300@vmware.com>
Date: Wed, 22 Mar 2006 17:01:03 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       virtualization@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christopher Li <chrisl@vmware.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>, Andi Kleen <ak@suse.de>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Anne Holler <anne@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Jyothy Reddy <jreddy@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [Xen-devel] Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>	<200603222115.46926.ak@suse.de>	<20060322214025.GJ15997@sorel.sous-sol.org> <4421EC44.7010500@us.ibm.com> <4421EFD9.8060402@vmware.com> <4421F190.2050908@us.ibm.com>
In-Reply-To: <4421F190.2050908@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
>
> Hrm, I was actually thinking that each of the VMI calls would be an 
> export (vmi_init, vmi_set_pxe, etc.).  I know that you want the 
> hypervisor to drive the inlining but I that's sufficiently hairy (not 
> to mention, there's not AFAIK performance data yet to justify it) that 
> I think it ought to be left for VMI 2.0.

That seems quite ok to me.  It is a little weird to have the VMI calls 
be an export when some of them really can never be properly callable C 
functions, and you have to overwrite the native code, so the linking 
step is .. well this magic disassembly glue again.  But it could be made 
to work, and we have discussed it before.

> Multi-licensing is fine as long as one is GPL :-)

I agree.  But it sort of defeats the point of the GPL if you can 
optionally redistribute the code under the BSD license as well.
