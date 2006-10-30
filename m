Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWJ3UXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWJ3UXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWJ3UXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:23:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:48591 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751694AbWJ3UXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:23:30 -0500
Date: Mon, 30 Oct 2006 12:22:51 -0800
From: Greg KH <greg@kroah.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.19-rc3-mm1 - udev doesn't work (was: ATI SATA controller not detected)
Message-ID: <20061030202251.GA1235@kroah.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <200610302055.21305.rjw@sisk.pl> <20061030200414.GA938@kroah.com> <200610302115.37688.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610302115.37688.rjw@sisk.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 09:15:37PM +0100, Rafael J. Wysocki wrote:
> Sorry, I was wrong.
> 
> The controller _is_ detected and handled properly, but udev is apparently
> unable to create the special device files for SATA drives/partitions even
> though CONFIG_SYSFS_DEPRECATED is set.

This config option should not affect the block device sysfs files at all
at this point in time.

What does 'tree /sys/block/' show?

If the files show up there properly, udev should handle them just fine.

> The system is SUSE 10.1 (udev-085-30.15).

That should not cause any problems.

thanks,

greg k-h
