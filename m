Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTFIV0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTFIVZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:25:43 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:42375 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S262135AbTFIVZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:25:28 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
To: dm-devel@sistina.com, Greg KH <greg@kroah.com>
Subject: Re: [dm-devel] Re: [RFC] device-mapper ioctl interface
Date: Mon, 9 Jun 2003 23:39:38 +0200
User-Agent: KMail/1.5.2
Cc: dm-devel@sistina.com, Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030605093943.GD434@fib011235813.fsnet.co.uk> <200306092203.50024.dphillips@sistina.com> <20030609203954.GA8021@kroah.com>
In-Reply-To: <20030609203954.GA8021@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306092339.38441.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 June 2003 22:39, Greg KH wrote:
> On Mon, Jun 09, 2003 at 10:03:50PM +0200, Daniel Phillips wrote:
> > On Friday 06 June 2003 19:17, Greg KH wrote:
> > > On Thu, Jun 05, 2003 at 10:39:43AM +0100, Joe Thornber wrote:
> > > > Here's the header file for the the proposed new ioctl interface for
> > > > dm.  We've tried to change as little as possible to minimise code
> > > > changes in LVM2 and EVMS.
> > >
> > > Minor comment:
> > > 	- please do not use uint_32t types in kernel header files.  Use
> > > 	  the proper __u32 type which is guarenteed to be the proper
> > > 	  size across the user/kernel boundry.
> >
> > We even have a flavor without the __'s:
> >
> >    http://lxr.linux.no/source/include/asm-i386/types.h?v=2.5.56#L47
> >
> > A little easier on the eyes, imho.
>
> But they are not the same.
>  - "__" means this variable will be the same size across the
>    kernel/userspace boundry.
>  - without the "__" means this variable will only be this size within
>    the kernel.
>
> Use "__" for variables being seen by userspace.  Otherwise use the
> types without "__".

Indeed, and (to restate the obvious) ioctl interfaces will need the __ form.

On the other hand, a quick tour through the current tree shows the __ form 
being used in a lot more places than it's strictly needed.  Although there's 
no entry in the style guide for this, perhaps we should consider one.

Regards,

Daniel

