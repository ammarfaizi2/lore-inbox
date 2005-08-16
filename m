Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbVHPS4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbVHPS4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVHPS4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:56:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030297AbVHPS4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:56:20 -0400
Date: Tue, 16 Aug 2005 11:56:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       virtualization@lists.osdl.org, Chris Wright <chrisw@osdl.org>,
       Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH 7/14] i386 / Add some descriptor convenience  functions
Message-ID: <20050816185602.GD7762@shell0.pdx.osdl.net>
References: <200508161306_MC3-1-A75D-6645@compuserve.com> <43022B0A.4030807@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43022B0A.4030807@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> I think so too.  I merely moved the code here and didn't notice it in 
> all this excitement.
> 
> 0x00cf9a000xff306600  =>
> 
> Present CPL-0 32-bit code segment, base 0x0000ff30, limit 0xf6601 pages, 
> for which desc_empty(desc) is true.
> 
> Thankfully, this is not used as a security check, but it can falsely 
> overwrite TLS segments with carefully chosen base / limits.  I do not 
> believe this is an issue in practice, but it is a kernel bug.
> 
> Nice catch.  Looks like it affects all 2.6.X kernels.

Thanks, I added this to virt tree, and will push baseline fix up.

thanks,
-chris
