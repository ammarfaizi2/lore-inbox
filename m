Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVCIXOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVCIXOB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVCIXNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:13:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11023 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262526AbVCIWtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:49:42 -0500
Date: Wed, 9 Mar 2005 22:49:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@osdl.org>, Greg KH <greg@kroah.com>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309224935.K25398@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@muc.de>, Chris Wright <chrisw@osdl.org>,
	Greg KH <greg@kroah.com>, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de> <20050309182822.GU5389@shell0.pdx.osdl.net> <20050309194401.GD17918@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050309194401.GD17918@muc.de>; from ak@muc.de on Wed, Mar 09, 2005 at 08:44:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 08:44:01PM +0100, Andi Kleen wrote:
> But it risks code drift like we had in 2.4 with older kernels 
> having more fixes than the newer kernel. And that way lies madness.

I believe it's going to work like this:

* simple fixes are submitted to Linus and -stable, and are appropriately
  merged.
* complex "correct" fixes too large for -stable are submitted to Linus,
  with a simplified version for -stable.

When the next Linus kernel is released, anything in the previous -stable
series is effectively discarded, and the next -stable series is produced
from the new release point.

Obviously, the -stable sucker can continue with his existing -stable
series if he so wishes, but I would expect that any fixes in, eg,
2.6.11.x would not be propagated by the -stable sucker to 2.6.12.x.

This may be a good thing - it encourages people to get the fixes into
the Linus tree, thereby keeping the code drift to a minimum.  Any
drift would only exist for one of these -stable branches, which may
only survive for maybe one Linus kernel release cycle.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
