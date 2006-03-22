Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWCVXLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWCVXLd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWCVXLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:11:33 -0500
Received: from ns2.suse.de ([195.135.220.15]:14270 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751436AbWCVXLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:11:32 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation II
Date: Wed, 22 Mar 2006 23:38:42 +0100
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
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <200603222239.46604.ak@suse.de> <4421D379.3090405@vmware.com>
In-Reply-To: <4421D379.3090405@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603222338.44919.ak@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 23:45, Zachary Amsden wrote:

> I propose an entirely different approach - use segmentation. 

That would require a lot of changes to save/restore the segmentation
register at kernel entry/exit since there is no swapgs on i386. 
And will be likely slower there too and also even slow down the 
VMI-kernel-no-hypervisor.

Still might be the best option.

How did that rumoured Xenolinux-over-VMI implementation solve that problem?

-Andi
