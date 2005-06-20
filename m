Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVFTRe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVFTRe2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 13:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVFTRe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 13:34:28 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:51839 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261400AbVFTReX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 13:34:23 -0400
Date: Mon, 20 Jun 2005 10:34:11 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Nick Warne <nick@linicks.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Message-ID: <20050620173411.GB15212@suse.de>
References: <200506181332.25287.nick@linicks.net> <42B45173.6060209@pobox.com> <200506181806.49627.nick@linicks.net> <200506201304.10741.vda@ilport.com.ua> <20050620164800.GA14798@suse.de> <42B6FBC7.5000900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B6FBC7.5000900@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 01:24:23PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >On Mon, Jun 20, 2005 at 01:04:10PM +0300, Denis Vlasenko wrote:
> >
> >>Greg, any plans to distribute udev and hotplug within kernel tarballs
> >>so that people do not need to track such changes continuously?
> >
> >
> >Nope.  But if you use udev, you should read the announcements for new
> >releases, as I did say this was required for 2.6.12, and gave everyone a
> >number of weeks notice :)
> 
> Since udev is required for booting, it sounds like you're putting people 
> in an upgrade-or-no-boot situation.

Well, they don't _have_ to upgrade their kernel :)

> That's lame.  The kernel should support udev's out in the field, on 
> people's boxes (RHEL, SLES?, Fedora, ...).

This was caused by an unfortunate assumption in older versions of udev
about what was contained in the sysfs tree.  udev is now fixed to not
make that assumption.  So this was not a kernel bug, but a udev/libsysfs
one (and I wasn't going to keep the old kernel behavior for this minor
issue.)

As for working with people's boxes, only the very oldest versions of
udev (like the reported 030 version which is a year old and I do not
think shipped by any distro) would have the "lockup" issue.  On all of
the other ones, only custom rules written by users would have issues
(meaning, not work).  I do not know of any shipping, supported distro
that currently has a boot lockup issue (if so, please let me know.)

thanks,

greg k-h
