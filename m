Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265766AbUFOQiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUFOQiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265769AbUFOQiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:38:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:56464 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265766AbUFOQiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:38:01 -0400
Date: Tue, 15 Jun 2004 09:36:44 -0700
From: Greg KH <greg@kroah.com>
To: Shaun Colley <shaunige@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c device driver bugs
Message-ID: <20040615163644.GB14078@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <20040615161307.GA13722@kroah.com> <20040615163244.10651.qmail@web25103.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615163244.10651.qmail@web25103.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 05:32:44PM +0100, Shaun Colley wrote:
> Okay, thanks for the info greg.
> 
> > Yes, this was a security issue a year ago, but has
> > been fixed since
> > then.  Vendors have released kernels that fix this
> > issue for their 2.4
> > kernels.  If not, I suggest you contact your vendor.
> 
> What I meant by silent was, did the issue actually get
> mentioned in any of the distro vendor's advisories?

I did see it be mentioned in a few.  But it really isn't that big of a
problem, as all distros seemed to have their /dev/i2c* nodes set to:
	$ ls -l /dev/i2c*
	crw-------  1 root root 89, 0 Feb 23 13:02 /dev/i2c0
	crw-------  1 root root 89, 0 Feb 23 13:02 /dev/i2c-0
	crw-------  1 root root 89, 1 Feb 23 13:02 /dev/i2c1
	crw-------  1 root root 89, 1 Feb 23 13:02 /dev/i2c-1

Which prevents any normal user from exploiting this issue.

thanks,

greg k-h
