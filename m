Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVE1QQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVE1QQd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 12:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVE1QQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 12:16:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1809 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261155AbVE1QQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 12:16:30 -0400
Date: Sat, 28 May 2005 17:16:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Will __pa(vmalloc()) ever work?
Message-ID: <20050528171626.B4711@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <4297746C.10900@ammasso.com> <20050527192925.GA8250@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050527192925.GA8250@infradead.org>; from hch@infradead.org on Fri, May 27, 2005 at 08:29:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 08:29:25PM +0100, Christoph Hellwig wrote:
> On Fri, May 27, 2005 at 02:26:36PM -0500, Timur Tabi wrote:
> > I have a driver that calls __pa() on an address obtained via vmalloc().  
> > This is not supposed to work, and yet oddly it appears to.  Is there a 
> > possibility, even a remote one, that __pa() will return the correct 
> > physical address for a buffer returned by the vmalloc() function?
> 
> It will return the correct physical address for the start of the buffer.

__pa() is only defined to works on the direct-mapped kernel region.
The fact that it works on some architectures should be viewed as a
bug.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
