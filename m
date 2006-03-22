Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWCVWv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWCVWv0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWCVWv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:51:26 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:24194 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751410AbWCVWvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:51:24 -0500
Date: Wed, 22 Mar 2006 14:51:17 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
Message-ID: <20060322225117.GM15997@sorel.sous-sol.org>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org> <4421CCA8.4080702@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4421CCA8.4080702@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Chris Wright wrote:
> >Strongly agreed.  The strict ABI requirements put forth here are not
> >in-line with Linux, IMO.  I think source compatibility is the limit of
> >reasonable, and any ROM code be in-tree if something like this were to
> >be viable upstream.
> 
> Strongly disagree.  Without an ABI, you don't have binary 
> compatibility.  Without binary compatibility, you have no way to inline 
> any hypervisor code into the kernel.  And this is key for performance.  
> The ROM code is being phased out.

With source compatibility you get the ABI at compile time.  This is how
Linux handles internal interfaces.  This is about an internal interface
between kernel and a platform layer.  The raw hypervisor interface is
hidden (translations done in the platform layer), and the hypervisor
needs to provide stable ABI.

> Is it the strictness of the ABI that is the problem?  I don't like 
> constraining the native register values any much either, but it was the 
> expedient thing to do.  The ABI can be relaxed quite a bit, but it has 
> to be there.

It's the very notion of creating such a large internal binary compatible
interface.

> The idea of in-tree ROM code doesn't make sense.  The entire point of 
> this layer of code is that it is modular, and specific to the 
> hypervisor, not the kernel.  Once you lift the shroud and combine the 
> two layers, you have lost all of the benefit that it was supposed to 
> provide.

You could compile all platform layers you want to support with the kernel.

thanks,
-chris
