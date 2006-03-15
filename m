Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWCOKZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWCOKZa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 05:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWCOKZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 05:25:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:445 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932213AbWCOKZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 05:25:29 -0500
Date: Wed, 15 Mar 2006 10:25:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
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
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface	proposal
Message-ID: <20060315102522.GA5926@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zachary Amsden <zach@vmware.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>,
	Xen-devel <xen-devel@lists.xensource.com>,
	Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
	Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
	Pratap Subrahmanyam <pratap@vmware.com>,
	Christopher Li <chrisl@vmware.com>,
	Joshua LeVasseur <jtl@ira.uka.de>, Chris Wright <chrisw@osdl.org>,
	Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
	Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
	Jan Beulich <jbeulich@novell.com>,
	Ky Srinivasan <ksrinivasan@novell.com>,
	Wim Coekaerts <wim.coekaerts@oracle.com>,
	Leendert van Doorn <leendert@watson.ibm.com>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <1142273346.3023.38.camel@laptopd505.fenrus.org> <4415B857.9010902@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4415B857.9010902@vmware.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 10:22:15AM -0800, Zachary Amsden wrote:
> >Why can't vmware use the Xen interface instead?
> >  
> 
> We could.  But it is our opinion that the Xen interface is unnecessarily 
> complicated, without a clean separation between the layer of interaction 
> with the hypervisor and the kernel proper.  The interface we propose we 
> believe is more powerful, and more conducive to performance 
> optimizations while providing significant advantages - most 
> specifically, a single binary image that is properly virtualizable on 
> multiple hypervisors and capable of running on native hardware.

I agree with Zach here, the Xen hypervisor <-> kernel interface is
not very nice.  This proposal seems like a step forward althogh it'll
probably need to go through a few iterations.  Without and actually
useable opensource hypevisor reference implementation it's totally
unacceptable, though.

