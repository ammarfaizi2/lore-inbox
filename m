Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbUJ1OSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbUJ1OSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUJ1OSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:18:49 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:40877 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261281AbUJ1ONX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:13:23 -0400
From: David Brownell <david-b@pacbell.net>
To: Colin Leroy <colin@colino.net>
Subject: Re: [linux-usb-devel] 2.6.10-rc1 OHCI usb error messages
Date: Thu, 28 Oct 2004 07:10:22 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20041026172843.6ac07c1a.colin@colino.net> <200410271559.37540.david-b@pacbell.net> <20041028110731.74ac5eb5.colin@colino.net>
In-Reply-To: <20041028110731.74ac5eb5.colin@colino.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410280710.22564.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 02:07, Colin Leroy wrote:
> On 27 Oct 2004 at 15h10, David Brownell wrote:
> 
> > So:  since it's not being actively used then, why shouldn't the
> > root hub (or any other device) be suspended?  During boot, or at
> > any other time.  So long as it works when you plug in a USB device,
> > it looks to me like everything is behaving quite reasonably.
> 
> That's right. Just that it didn't do so previously, so i didn't think 
> of that.

You won't be alone either ... so I'll be glad to get
rid of those pointless usbcore "non-error" messages!


> > So if something's timing out, it's for some other reason.
> > (Such as bugs in "lsusb"; the "usbutils" package is overdue
> > for a new release, it's changed a lot since the 0.11 tarball
> > that's widely available.)
> 
> Yes, btw, I once sent a patch about lsusb endianness problems, and didn't
> hear anything back about it. I ended up sending the patch to the gentoo
> guys so that at least my distro is fixed:

Thomas put "usbutils" into CVS at linux-usb.sf.net and
that version has the Debian patches to make it use the
system's "libusb" instead of its own older snapshot.
Plus bugfixes, and printing more descriptors.

It looks like libusb-0.1.8 still expects the kernel to
return a little-endian device descriptor rather than
its private byteswapped version.

- Dave
