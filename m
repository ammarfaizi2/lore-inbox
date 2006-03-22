Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932724AbWCVU7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbWCVU7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWCVU7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:59:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:6834 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932724AbWCVU7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:59:02 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC, PATCH 19/24] i386 Vmi mmu changes
Date: Wed, 22 Mar 2006 21:20:04 +0100
User-Agent: KMail/1.9.1
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
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
References: <200603131813.k2DIDo1g005760@zach-dev.vmware.com>
In-Reply-To: <200603131813.k2DIDo1g005760@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603222120.06145.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 19:13, Zachary Amsden wrote:
> MMU code movement.  Unfortunately, this one is a little bit more
> complicated than the rest.  We have to override the default accessors
> that directly write to page table entries.  Because of the 2/3-level
> PAE split in Linux, this turned out to be really ugly at first, but
> by allowing the sub-arch layer to override the definitions and keeping
> the native definitions in place, the code becomes much cleaner.

This patch definitely needs to be split up more.

-Andi
