Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTFIVyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTFIVyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:54:45 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:10441 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262175AbTFIVyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:54:44 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
To: dm-devel@sistina.com, Greg KH <greg@kroah.com>,
       Joe Thornber <thornber@sistina.com>
Subject: Re: [dm-devel] Re: [RFC] device-mapper ioctl interface
Date: Tue, 10 Jun 2003 00:08:54 +0200
User-Agent: KMail/1.5.2
Cc: dm-devel@sistina.com, Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030605093943.GD434@fib011235813.fsnet.co.uk> <20030606171700.GC12231@kroah.com>
In-Reply-To: <20030606171700.GC12231@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306100008.54715.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 June 2003 19:17, Greg KH wrote:
> On Thu, Jun 05, 2003 at 10:39:43AM +0100, Joe Thornber wrote:
> > Here's the header file for the the proposed new ioctl interface for
> > dm.  We've tried to change as little as possible to minimise code
> > changes in LVM2 and EVMS.
>
> Minor comment:
> 	- please do not use uint_32t types in kernel header files.  Use
> 	  the proper __u32 type which is guarenteed to be the proper
> 	  size across the user/kernel boundry.

I'm not sure what we were both smoking, but obviously all flavors of u32 
should be the same size regardless of where they are located.  As I 
understand it, the only interesting difference between __u32 and u32 is that 
the former is standard C while the latter is Linux's (sensible) local 
dialect.

Regards,

Daniel

