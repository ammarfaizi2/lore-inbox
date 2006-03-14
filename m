Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWCNP0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWCNP0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWCNP0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:26:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50628 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932105AbWCNP0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:26:01 -0500
Date: Tue, 14 Mar 2006 15:25:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [RFC, PATCH 3/24] i386 Vmi interface definition
Message-ID: <20060314152559.GC16921@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zachary Amsden <zach@vmware.com>,
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
References: <200603131801.k2DI1EAe005650@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131801.k2DI1EAe005650@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 10:01:14AM -0800, Zachary Amsden wrote:
> Master definition of VMI interface, including calls, constants, and
> interface version.

This is a totally horrible style.  There's absolutely no need to find
your own sized integer types, please use the standard kernel ones.
Also don't use camel case and #pack but rather __attribute__.
Also please avoid // comments.

Also please remove all the historical version garbage, we don't care about
that.
