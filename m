Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWCWAME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWCWAME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWCWALs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:11:48 -0500
Received: from mx1.suse.de ([195.135.220.2]:6278 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964850AbWCWAL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:11:28 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation II
Date: Thu, 23 Mar 2006 00:37:58 +0100
User-Agent: KMail/1.9.1
Cc: virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <200603222338.44919.ak@suse.de> <4421E3C4.2060808@vmware.com>
In-Reply-To: <4421E3C4.2060808@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603230038.00583.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 00:54, Zachary Amsden wrote:
> Andi Kleen wrote:
> > On Wednesday 22 March 2006 23:45, Zachary Amsden wrote:
> >
> >   
> >> I propose an entirely different approach - use segmentation. 
> >>     
> >
> > That would require a lot of changes to save/restore the segmentation
> > register at kernel entry/exit since there is no swapgs on i386. 
> > And will be likely slower there too and also even slow down the 
> > VMI-kernel-no-hypervisor.
> >   
> 
> There are no changes required to the kernel entry / exit paths.  With 
> save/restore segment support in the VMI, reserving one segment for the 
> hypervisor data area is easy.

Ok that might work yes.

> > Still might be the best option.
> >
> > How did that rumoured Xenolinux-over-VMI implementation solve that problem?
> >   
> 
> !CONFIG_SMP  -- as I believe I saw in the latest Xen patches sent out as 
> well?

Ah, cheating. This means the rumoured benchmark numbers are dubious too I guess.

-Andi
