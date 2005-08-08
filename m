Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753216AbVHHBgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbVHHBgT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 21:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbVHHBgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 21:36:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753216AbVHHBgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 21:36:18 -0400
Date: Sun, 7 Aug 2005 18:36:14 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: [PATCH] abstract out bits of ldt.c
Message-ID: <20050808013614.GF7991@shell0.pdx.osdl.net>
References: <372830000.1123456808@[10.10.2.4]> <20050807234411.GE7991@shell0.pdx.osdl.net> <374910000.1123459025@[10.10.2.4]> <20050807174129.20c7202f.akpm@osdl.org> <20050808004645.GT7762@shell0.pdx.osdl.net> <42F6AF8E.60107@vmware.com> <20050808010828.GU7762@shell0.pdx.osdl.net> <42F6B254.2090404@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F6B254.2090404@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Doesn't that require 16 pages per CPU?  That seems excessive to impose 
> on a native build.  Perhaps we could get away with 1 page per CPU for 
> the GDT on native boots and bump that up to 16 if compiling for a 
> virtualized sub-architecture - i.e. move GDT to a page aligned struct 
> for native (doesn't cost too much), and give it MACH_GDT_PAGES of space 
> which is defined by the sub-architecture.

For Xen, the gdt is one page per cpu (so it's not one page per table
entry).

thanks,
-chris
