Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVCPBFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVCPBFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 20:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVCPBFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 20:05:16 -0500
Received: from waste.org ([216.27.176.166]:57254 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262384AbVCPBEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 20:04:38 -0500
Date: Tue, 15 Mar 2005 17:04:32 -0800
From: Matt Mackall <mpm@selenic.com>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-ID: <20050316010432.GS32638@waste.org>
References: <4235BC29.2060009@lougher.demon.co.uk> <20050315031251.GI3163@waste.org> <42376ED3.4090502@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42376ED3.4090502@lougher.demon.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 11:25:07PM +0000, Phillip Lougher wrote:
> Matt Mackall wrote:
> >
> >>+config SQUASHFS_1_0_COMPATIBILITY
> >>+	bool "Include support for mounting SquashFS 1.x filesystems"
> >
> >How common are these? It would be nice not to bring in legacy code.
> 
> Squashfs 1.x filesystems were the previous file format.  Embedded 
> systems tend to be conservative, and so there are quite a few systems 
> out there using 1.x filesystems.  I've also heard of quite a few cases 
> where Squashfs is used as an archival filesystem, and so there's 
> probably quite a few 1.x fileystems around for this reason.
>
> One issue which I'm aware of here is deciding what getting squashfs 
> support into the kernel is meant to answer.  I'm asking for it to be put 
> into the kernel because developers out there are asking me to put it in 
> the kernel - because they don't want to continually (re)patch their kernels.

My suggestion would be to break out the 1.x code into a separate patch
and encourage everyone to convert to 2.x. No one has ever created a
1.x fs with the expectation it'll work on an unpatched kernel, so they
don't lose anything. And no one should be creating such any more, right?

> >>+	unsigned int		s_major:16;
> >>+	unsigned int		s_minor:16;
> >
> >What's going on here? s_minor's not big enough for modern minor
> >numbers.
> 
> What is the modern size then?

Minors are 22 bits, majors are 10. May grow to 32 each at some point.

-- 
Mathematics is the supreme nostalgia of our time.
