Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267787AbUG3Utp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267787AbUG3Utp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267831AbUG3Utp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:49:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:61080 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267787AbUG3Utn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:49:43 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 13:49:12 -0700
User-Agent: KMail/1.6.2
Cc: Martin Mares <mj@ucw.cz>, Jon Smirl <jonsmirl@yahoo.com>,
       Matthew Wilcox <willy@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20040730201052.GA5249@ucw.cz> <20040730203225.81054.qmail@web14926.mail.yahoo.com> <20040730204121.GA5718@ucw.cz>
In-Reply-To: <20040730204121.GA5718@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301349.12020.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 30, 2004 1:41 pm, Martin Mares wrote:
> Hello!
>
> > Reasons for ROMs in sysfs:
>
> Good ones, although I believe than re-initializing cards after resume
> should better be in the kernel.

I don't think anyone wants an x86 emulator builtin to the kernel for this 
purpose.

> And, even with your list of reasons, it is still very unlikely that anybody
> will ever need the cached copy :-)  I still do not see a device which
> would have shared decoders AND needed such initialization in userspace.
>
> (Also, while we are speaking about video hardware -- they either have no
> kernel driver, so nobody can ask for the copy, or they have one, but in
> that case the BIOS mode switching calls and similar things can be
> accomplished by the kernel driver with no need of messing with the ROM in
> the userspace.)

We can get away without caching a copy of the ROM in the kernel if we require 
userspace to cache it before the driver takes control of the card (i.e. at 
POST time).  Otherwise, the kernel will have to take care of it.

Jesse
