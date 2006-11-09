Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753032AbWKIHWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbWKIHWZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 02:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbWKIHWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 02:22:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:64464 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1753032AbWKIHWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 02:22:25 -0500
Date: Thu, 9 Nov 2006 07:22:16 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: kenneth.w.chen@intel.com, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch] fix up generic csum_ipv6_magic function prototype
Message-ID: <20061109072216.GL29920@ftp.linux.org.uk>
References: <000301c703a3$0eedb340$ff0da8c0@amr.corp.intel.com> <20061108.230059.57444310.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108.230059.57444310.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 11:00:59PM -0800, David Miller wrote:
> From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
> Date: Wed, 8 Nov 2006 18:02:06 -0800
> 
> > The generic version of csum_ipv6_magic has the len argument declared as
> > __u16, while most arch dependent version declare it as __u32.  After
> > looking at the call site of this function, I come up to a conclusion
> > that __u32 is a better match with the actual usage.
> > 
> > Hence, patch to change argument type for greater consistency.
> > 
> > Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> 
> Architecture implementations such as the ones for m32r and parisc have
> the same problem, so "for consistency" please fix them up as well.
> 
> Thanks a lot.

Please, hold.  One of the patches in my queue gets sanitized prototypes
for all that stuff and it'll conflict like crazy.

I haven't touch that argument yet; if there's an agreement as to what should
we switch to, I'll do that.  So... does everyone agree that u32 is the way
to go?
