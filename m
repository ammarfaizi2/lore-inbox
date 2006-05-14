Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWENBij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWENBij (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 21:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWENBij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 21:38:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750762AbWENBii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 21:38:38 -0400
Date: Sat, 13 May 2006 18:35:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ak@suse.de, hch@infradead.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com
Subject: Re: [RFC PATCH 00/35] Xen i386 paravirtualization support
Message-Id: <20060513183520.79a0d44e.akpm@osdl.org>
In-Reply-To: <20060509152240.GA17837@infradead.org>
References: <20060509084945.373541000@sous-sol.org>
	<4460AC01.5020503@mbligh.org>
	<20060509150701.GA14050@infradead.org>
	<p73k68v4444.fsf@bragg.suse.de>
	<20060509152240.GA17837@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, May 09, 2006 at 05:20:11PM +0200, Andi Kleen wrote:
> > > It's also wrong.  There's more than one hypervisor and Xen shouldn't just
> > > grab this namespace.  make it xen_ or xenhv_.
> > 
> > You should reject the recent "hypervisor file system" with the same
> > argument then.
> 
> I prefer it would become lparfs or something like that indeed.

Yes, it did get renamed to something s390-specific.

Also, note

	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/driver-core-add-sys-hypervisor-when-needed.patch

which creates the /sys/hypervisor directory.  With the expectation that
_all_ hypervisorish subsystems will base their sysfs trees in there.

