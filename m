Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVHQAWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVHQAWu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVHQAWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:22:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750773AbVHQAWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:22:49 -0400
Date: Tue, 16 Aug 2005 17:22:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, zach@vmware.com, akpm@osdl.org,
       chrisl@vmware.com, hpa@zytor.com, Keir.Fraser@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, m+Ian.Pratt@cl.cam.ac.uk,
       mbligh@mbligh.org, pratap@vmware.com, virtualization@lists.osdl.org,
       zwame@arm.linux.org.uk
Subject: Re: [PATCH 1/14] i386 / Make write ldt return error code
Message-ID: <20050817002239.GW7762@shell0.pdx.osdl.net>
References: <200508110452.j7B4qpSE019505@zach-dev.vmware.com> <20050816234330.GF27628@wotan.suse.de> <20050817000618.GT7762@shell0.pdx.osdl.net> <20050817001226.GB3996@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817001226.GB3996@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Tue, Aug 16, 2005 at 05:06:18PM -0700, Chris Wright wrote:
> > In this case the callers do propagate the error (unless you mean
> > userspace doesn't check return value from syscall, which is same problem
> > if copy_from_user failed, for example).  Xen has done some more wrapping
> 
> Nothing checks them in user space.
> 
> Also how would you handle them anyways? It just doesn't make sense.

Yes, I see your point, although copy_from_user failing has similar issue
if userspace isn't checking errors.  But this one is not critical.

thanks,
-chris
