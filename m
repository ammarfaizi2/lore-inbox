Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbUKDWi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbUKDWi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUKDWih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:38:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:59097 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261331AbUKDWeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:34:23 -0500
Date: Thu, 4 Nov 2004 14:34:22 -0800
From: Chris Wright <chrisw@osdl.org>
To: Serge Hallyn <hallyn@cs.wm.edu>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] [1/6] LSM Stacking: Replace LSM void* with arrays
Message-ID: <20041104143421.Z2357@build.pdx.osdl.net>
References: <1099609471.2096.10.camel@serge.austin.ibm.com> <1099609599.2096.13.camel@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1099609599.2096.13.camel@serge.austin.ibm.com>; from hallyn@cs.wm.edu on Thu, Nov 04, 2004 at 05:06:44PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge Hallyn (hallyn@cs.wm.edu) wrote:
> The attached patch replaced the LSM security fields on kernel
> objects with an array of pointers, so that more than 1 LSM
> can annotate information on kernel objects.

This will add (default) 12 extra bytes to each LSM tagged object
(including inodes, which a quick snapshot on my system is ~365000 inodes ==
~4M).  Also, I don't think the assignment loop should be exposed to core.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
