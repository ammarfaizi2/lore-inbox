Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWHHFUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWHHFUO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 01:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWHHFUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 01:20:13 -0400
Received: from brick.kernel.dk ([62.242.22.158]:36454 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750835AbWHHFUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 01:20:12 -0400
Date: Tue, 8 Aug 2006 07:21:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.18-rc3-mm2
Message-ID: <20060808052117.GB4304@suse.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <20060806155454.50935786.akpm@osdl.org> <200608071115.45307.rjw@sisk.pl> <200608072234.12238.rjw@sisk.pl> <20060807135537.96059a1e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807135537.96059a1e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07 2006, Andrew Morton wrote:
> On Mon, 7 Aug 2006 22:34:12 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Monday 07 August 2006 11:15, Rafael J. Wysocki wrote:
> > > On Monday 07 August 2006 00:54, Andrew Morton wrote:
> > > > On Mon, 7 Aug 2006 00:42:10 +0200
> > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > 
> > > > > On Sunday 06 August 2006 12:08, Andrew Morton wrote:
> > > > > > 
> > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> > > > > 
> > > > > My box's (Asus L5D, x86_64) keyboard doesn't work on this kernel at all, even
> > > > > if I boot with init=/bin/bash.  On the 2.6.18-rc2-mm1 it worked.
> > > > > 
> > > > > Unfortunately I have no indication what can be wrong, no oopses, no error
> > > > > messages in dmesg, nothing.
> > > > > 
> > > > > Right now I'm doing a binary search for the offending patch.
> > > > > 
> > > > 
> > > > Thanks.  I'd zoom in on
> > > > hdaps-handle-errors-from-input_register_device.patch and git-input.patch.
> > > 
> > > None of these, but close: remove-polling-timer-from-i8042-v2.patch breaks
> > > things here.  [FYI, the box is booted with "noapic", because the IRQ sharing
> > > doesn't work otherwise due to a BIOS issue, so it may be related.]
> > > 
> > > Attached is the dmesg output with i8042.debug=1 for Dmitry.  It's from
> > > 2.6.18-rc3 with -mm2 partially applied (up to and including
> > > logips2pp-fix-mx300-button-layout.patch).  I'll apply the rest tonight, after
> > > I find the patch that broke suspend for me.
> > 
> > Unfortunately this one is git-block.patch.  I have no idea which part of it
> > may break the suspend.
> 
> ow, that tree is pretty huge at present.
> 
> > It hangs during suspend, right after the memory has been shrunk, when devices
> > should be suspended.  After pressing SysRq-P it shows it's spinning in the
> > idle thread and then hangs hard.
> 
> OK, thanks for doing that.  I'll drop git-block until we can get it sorted.

I think I know what it is, hang on.

-- 
Jens Axboe

