Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWELIjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWELIjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 04:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWELIjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 04:39:35 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:55702 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751078AbWELIje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 04:39:34 -0400
Date: Fri, 12 May 2006 09:38:40 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Jan Beulich <jbeulich@novell.com>
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [Xen-devel] Re: [RFC PATCH 07/35] Make LOAD_OFFSET defined by subarch
Message-ID: <20060512083839.GI7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085150.509458000@sous-sol.org> <44627733.4010305@vmware.com> <20060511164300.GA7834@cl.cam.ac.uk> <44644B91.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44644B91.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 08:47:13AM +0200, Jan Beulich wrote:
> >I've updated our loader to support this now, so that this patch is
> >no longer necessary.  I have at the same time added a new field to
> >xen_guest which allows specifying the entry point, allowing us to have
> >a different entry point when running the kernel image on Xen.
> 
> Why do you need a separate entry point here? The code should be able to figure out which mode it is run in without
> problems...

I think it's the cleanest way to have different startup code for
native and non-native in the same kernel.  But even if that's not
needed (for Linux), then you can have it point at the same address.
It is also always pointing to a virtual address, while the elf header
one now points to a physical address which doesn't make much sense
in the environment we start the kernel.

    christian

