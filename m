Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbUKLAin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbUKLAin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbUKLAfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:35:50 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:20715 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262439AbUKLAeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:34:19 -0500
Date: Thu, 11 Nov 2004 16:28:41 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
Message-ID: <20041112002841.GB11595@kroah.com>
References: <1099346276148@kroah.com> <10993462773570@kroah.com> <20041102223229.A10969@flint.arm.linux.org.uk> <20041107152805.B4009@flint.arm.linux.org.uk> <20041110013700.GF9496@kroah.com> <16785.33677.704803.889900@cargo.ozlabs.ibm.com> <20041110083629.A17555@flint.arm.linux.org.uk> <16786.35271.622222.193502@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16786.35271.622222.193502@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 08:36:07AM +1100, Paul Mackerras wrote:
> Russell King writes:
> 
> > On Wed, Nov 10, 2004 at 01:57:17PM +1100, Paul Mackerras wrote:
> > > So we can get a driver's probe method called concurrently with its
> > > bus's suspend or resume method.
> > 
> > If correct, we probably have rather a lot of buggy drivers, because
> > I certainly was not aware that this could happen.  I suspect the
> > average driver writer also would not be aware of that.
> 
> No doubt.  I'd still like to hear from Greg or Pat about what the
> concurrency rules are supposed to be, or were intended to be.

They are still under flux as to what they should be :)

I'm currently working on reworking all of the locking in the driver
core, to document, and fix the number of issues that suspend, and
manual disconnect, and manual attach are causing.  It should also fix
the issue that I know you want Russell, namely adding a new device from
a probe() callback.

See the other threads about manual disconnect in the driver model on
lkml for some other details.  I'll post more here when I have some
working code.

thanks,

greg k-h
