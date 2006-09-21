Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbWIUWLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWIUWLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWIUWLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:11:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7323 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750726AbWIUWLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:11:19 -0400
Date: Thu, 21 Sep 2006 18:10:58 -0400
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Message-ID: <20060921221058.GM26683@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200609202120.58082.rjw@sisk.pl> <200609202154.39377.rjw@sisk.pl> <20060921213253.GF2245@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921213253.GF2245@elf.ucw.cz>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 11:32:53PM +0200, Pavel Machek wrote:
 > On Wed 2006-09-20 21:54:38, Rafael J. Wysocki wrote:
 > > In order to use a swap file with swsusp we need to know the offset at which
 > > its swap header is located.  However, the swap header is always located in the
 > > first block of the swap file and it's quite easy to make sys_swapon() print
 > > the offset of the swap file's (or swap partition's) first block.
 > > 
 > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
 > 
 > ACK.
 > 
 > (main point of this is that it changes user-visible printk, but that's
 > probably okay, and way better than changing /proc files...)

As a user-interface, "read the number from dmesg that swapon printk'd
and add that to your boot command line" is pretty damned awful.
It means that it's next to impossible for a distro installer to
support suspend-to-swapfile.  It's also incredibly fragile to rely
on that file always remaining in that part of the disk.

	Dave
