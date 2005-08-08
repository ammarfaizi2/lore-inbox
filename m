Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753158AbVHHAqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbVHHAqs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 20:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753159AbVHHAqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 20:46:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753158AbVHHAqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 20:46:47 -0400
Date: Sun, 7 Aug 2005 17:46:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] abstract out bits of ldt.c
Message-ID: <20050808004645.GT7762@shell0.pdx.osdl.net>
References: <372830000.1123456808@[10.10.2.4]> <20050807234411.GE7991@shell0.pdx.osdl.net> <374910000.1123459025@[10.10.2.4]> <20050807174129.20c7202f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807174129.20c7202f.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> > xen_make_pages_readonly / xen_make_pages_writable ?
> 
> Well we don't want to assume "xen" at this stage.  We're faced with a
> choice at present: to make the linux->hypervisor interface be some
> xen-specific and xen-controlled thing, or to make it a more formal and
> controlled kernel interface which talks to a generic hypervisor rather than
> assuming it's Xen down there.

No, definietly not.  Xen is not appropriate global namespace.  Also,
it's not about pages at this point, it's about ldt handling.

> As long as it doesn't hamper performance or general code sanity, I think it
> would be better to make this a well-defined and controlled Linux interface.
> Some of the code to do that is starting to accumulate in -mm.  Everyone
> needs to sit down, take a look at the patches and the proposal and work out
> if this is the way to proceed.

We're doing that, but it's splintered and coming in from different angles.
It'd be better to get the story straight then submit patches, IMO.

thanks,
-chris
