Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTFIUY3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTFIUY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:24:29 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:28364 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261868AbTFIUY2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:24:28 -0400
Date: Mon, 9 Jun 2003 13:39:54 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Phillips <dphillips@sistina.com>
Cc: dm-devel@sistina.com, Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] Re: [RFC] device-mapper ioctl interface
Message-ID: <20030609203954.GA8021@kroah.com>
References: <20030605093943.GD434@fib011235813.fsnet.co.uk> <20030606171700.GC12231@kroah.com> <200306092203.50024.dphillips@sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306092203.50024.dphillips@sistina.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 10:03:50PM +0200, Daniel Phillips wrote:
> On Friday 06 June 2003 19:17, Greg KH wrote:
> > On Thu, Jun 05, 2003 at 10:39:43AM +0100, Joe Thornber wrote:
> > > Here's the header file for the the proposed new ioctl interface for
> > > dm.  We've tried to change as little as possible to minimise code
> > > changes in LVM2 and EVMS.
> >
> > Minor comment:
> > 	- please do not use uint_32t types in kernel header files.  Use
> > 	  the proper __u32 type which is guarenteed to be the proper
> > 	  size across the user/kernel boundry.
> 
> We even have a flavor without the __'s:
> 
>    http://lxr.linux.no/source/include/asm-i386/types.h?v=2.5.56#L47
> 
> A little easier on the eyes, imho.

But they are not the same.
 - "__" means this variable will be the same size across the
   kernel/userspace boundry.
 - without the "__" means this variable will only be this size within
   the kernel.

Use "__" for variables being seen by userspace.  Otherwise use the
types without "__".

Hope this helps,

greg k-h
