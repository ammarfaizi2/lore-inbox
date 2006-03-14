Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752320AbWCNRnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbWCNRnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbWCNRnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:43:51 -0500
Received: from cantor.suse.de ([195.135.220.2]:20457 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752336AbWCNRnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:43:49 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 17/24] i386 Vmi msr patch
Date: Tue, 14 Mar 2006 18:43:23 +0100
User-Agent: KMail/1.8
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
References: <200603131812.k2DICGJE005747@zach-dev.vmware.com> <200603141723.54365.ak@suse.de> <4416F038.90707@vmware.com>
In-Reply-To: <4416F038.90707@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603141843.24159.ak@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 17:32, Zachary Amsden wrote:

> There aren't really any.  There are some unexpected ones - such as
> setting SYSENTER_CS during a context switch, but only if leaving v8086
> mode, which isn't a common case.  But most importantly, the MSR
> functions were challenging to get correct, because they combine two
> novel elements - 64 bit values, as well as non-C calling conventions.
> They were actually some of the first functions I inlined, because I knew
> there would be problems, and the solutions would yield more powerful
> inlining macros.

That doesn't seem like a good rationale to add it to the kernel.

>
> > And I don't think it's a good idea to virtualize the TSC
> > without CPU support.
>
> We currently don't support configurations without a TSC.  But we're not
> trying to virtualize the TSC without CPU support.  It is possible.  But
> I have no idea _why_ you would want to do such a thing.

Don't change it then?

BTW I think it will be pretty tough to find enough competent reviewers
for your patchkit.

And is the spec still in flux or are you trying to implement an interface
for an specification that is already put into stone? 

-Andi
