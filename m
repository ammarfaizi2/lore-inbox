Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422850AbWJaHEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422850AbWJaHEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422856AbWJaHEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:04:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:22198 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422850AbWJaHEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:04:31 -0500
Date: Mon, 30 Oct 2006 23:03:51 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrew.j.wade@gmail.com, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [2.6.19-rc3-mm1] BUG at arch/i386/mm/pageattr.c:165
Message-ID: <20061031070351.GB14713@kroah.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <200610302203.37570.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20061030191340.1c7f8620.akpm@osdl.org> <200610302258.31613.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20061030211046.1c3d62b9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030211046.1c3d62b9.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 09:10:46PM -0800, Andrew Morton wrote:
> On Mon, 30 Oct 2006 22:58:11 -0500
> Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> 
> > > 
> > > hm.  Please send the .config
> > > 
> > Sure.
> > 
> > I've just found out that unsetting CONFIG_SYSFS_DEPRECATED makes the
> > crash go away. I can hack around the resulting udev incompatibility.
> > 
> > #
> > # Automatically generated make config: don't edit
> > # Linux kernel version: 2.6.19-rc3-mm1
> > # Mon Oct 30 19:31:03 2006
> 
> Well I tried to reproduce this, but I got such a psychedelic cornucopia of
> oopses at various bisection points amongst those sysfs patches that I think
> I'll just give up.
> 
> Greg, Kay: it's quite ugly.  I'll drop all those patches for now, and I
> suggest you do so too.  Have a play with the .config which Andrew sent..

No, please don't drop them.  We have tested these out on a lot of
different boxes.  So far everyone's problems have either been due to
something else in -mm (acpi patches), or because they did not read the
CONFIG_SYSFS_DEPRECATED Kconfig help text.

I have yet to see any real problems with these patches, except for your
build issue with the bonding drivers, which I'm fixing up right now.

So please leave them in, we did rework them a lot from the last round,
_and_ these patches are shipping successfully in the OpenSuSE 10.2 alpha
and beta release with no reported problems.  So they are not as ugly as
you imagine them to be :)

thanks,

greg k-h
