Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbUKLWgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbUKLWgO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbUKLWgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 17:36:14 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:2294 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262646AbUKLWfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 17:35:37 -0500
Date: Fri, 12 Nov 2004 14:02:10 -0800
From: Greg KH <greg@kroah.com>
To: Tim Hockin <thockin@google.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: small PCI probe patch for odd 64 bit BARs
Message-ID: <20041112220210.GA5316@kroah.com>
References: <20041111044809.GE19615@google.com> <20041110215142.3a81b426.akpm@osdl.org> <20041111173901.GH19615@google.com> <20041111175418.GA18811@kroah.com> <20041111205852.GP19615@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111205852.GP19615@google.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 12:58:52PM -0800, Tim Hockin wrote:
> On Thu, Nov 11, 2004 at 09:54:19AM -0800, Greg KH wrote:
> > I'll wait till you test this on 2.6 before applying it.
> 
> OK.  Tested now on real hardware in 32 bit and 64 bit kernels.  32 bit
> found another dumbness, that we can fix up.
> 
> Some PCI bridges default their UPPER prefetch windows to an unused state
> of base > limit.  We should not use those values if we find that.  It
> might be nice to reprogram them to 0, in fact.
> 
> Yes, BIOS should fix that up, but apparently, some do not.
> 
> Tim
> 
> Signed-Off-By: Tim Hockin <thockin@google.com>

Applied, thanks.

greg k-h
