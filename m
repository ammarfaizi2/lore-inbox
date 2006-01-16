Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWAPS2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWAPS2I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 13:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWAPS2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 13:28:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:52118 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750988AbWAPS2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 13:28:06 -0500
Date: Mon, 16 Jan 2006 09:45:17 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface
Message-ID: <20060116174517.GA1121@kroah.com>
References: <200601151831.32021.rjw@sisk.pl> <20060115234300.159688f7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060115234300.159688f7.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 11:43:00PM -0800, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > The patch assumes that the major and minor numbers of the snapshot device
> > will be 10 (ie. misc device) and 231, the registration of which has already been
> > requested.
> 
> Why does it need a statically-allocated major and minor?  misc_register()
> will generate a uevent and the device node should just appear...

Not everyone uses udev, so for things that are going to be in the kernel
tree, it's good to still register a major/minor number for them.

thanks,

greg k-h
