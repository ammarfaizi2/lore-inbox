Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTLLTWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTLLTV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:21:58 -0500
Received: from mail.directfb.org ([212.84.236.4]:26784 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261850AbTLLTVb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:21:31 -0500
Date: Fri, 12 Dec 2003 20:21:32 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Greg KH <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11: i2c-dev.h for userspace
Message-ID: <20031212192132.GC32169@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Greg KH <greg@kroah.com>, sensors@stimpy.netroedge.com,
	linux-kernel@vger.kernel.org
References: <20031212145652.GA30747@convergence.de> <20031212175656.GA2933@kroah.com> <20031212185357.GB32169@convergence.de> <20031212190105.GB3038@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212190105.GB3038@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 11:01:05AM -0800, Greg KH wrote:
> On Fri, Dec 12, 2003 at 07:53:57PM +0100, Johannes Stezenbach wrote:
> > 
> > I think you create a mess here. Other drivers have usable
> > API include files in /usr/include/linux, why are i2c.h and i2c-dev.h
> > special?
> 
> They aren't.  The rule is:
> 	DO NOT INCLUDE KERNEL HEADER FILES IN USERSPACE TOOLS.
> Please read the archives for lkml on why this is true.

I've read this statement multiple times on lkml, from Linus
and others. And you won't believe it: I'm all for a separation
of driver API includes and kernel includes.

But:

> Yeah, we do need a way to have "sanitized" kernel headers so that
> userspace can include them, but for now, use what your libc provides.

IMHO the problem is that Linux 2.6.0 is about to be released with some
broken driver API include files, and without a clear policy how driver
authors, glibc and distribution maintainers and should handle
the situation in a consistent way.


> > I think that sucks.
> 
> Sorry you feel that way, but the i2c header is not going to be any
> different than any other kernel header at this time.

I think they are different now.


Johannes
