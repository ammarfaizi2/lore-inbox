Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbULVGnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbULVGnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 01:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbULVGnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 01:43:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:33409 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261415AbULVGnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 01:43:19 -0500
Date: Tue, 21 Dec 2004 22:20:57 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, mochel@digitalimplant.org, axboe@suse.de
Subject: Re: /sys/block vs. /sys/class/block
Message-ID: <20041222062057.GC31513@kroah.com>
References: <1103526532.5320.33.camel@gaston> <20041220224950.GA21317@kroah.com> <1103612870.21771.22.camel@gaston> <20041222153449.46da0671.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222153449.46da0671.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 03:34:49PM +1100, Stephen Rothwell wrote:
> On Tue, 21 Dec 2004 08:07:50 +0100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > > Because /sys/block happened before /sys/class did.  Al Viro converted
> > > the block layer before I got the struct class stuff working properly
> > > during 2.5.
> > > 
> > > And yes, I would like to convert the block layer to use the class stuff,
> > > but for right now, I can't as class devices don't allow
> > > sub-classes-devices, and getting to that work is _way_ down on my list
> > > of things to do.
> > 
> > but can't we at least artificially move it down to /sys/class anyway for
> > the sake of a sane userland API ?
> 
> Can I then make the obvious suggestion: add a symlink in /sys/class
> linking to /sys/block and then reverse the symink once the above work has
> been done and /sys/class/block has been created?
> 
> Or is that too gross? :-)

It is gross.

But I guess I should ask, who really cares about this, so late in the
sysfs structure game?  Is /sys/block/ really a big problem for anyone?
And if it is, I'd much rather someone make the required driver core
changes to fix this up properly, than just put a symlink to paper over
some userspace issue.

And as Dan said, libsysfs already handles /sys/block just like any other
class structure, so a "sane" userland API already exists that fixes this
issue for you.

thanks,

greg k-h
