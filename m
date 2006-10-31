Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423657AbWJaVcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423657AbWJaVcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423651AbWJaVcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:32:06 -0500
Received: from ns2.suse.de ([195.135.220.15]:44223 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423650AbWJaVcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:32:03 -0500
Date: Tue, 31 Oct 2006 13:31:26 -0800
From: Greg KH <gregkh@suse.de>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Martin J. Bligh" <mbligh@google.com>, Mike Galbraith <efault@gmx.de>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-ID: <20061031213126.GA596@suse.de>
References: <454631C1.5010003@google.com> <45463481.80601@shadowen.org> <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com> <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com> <20061031065912.GA13465@suse.de> <4546FB79.1060607@google.com> <20061031075825.GA8913@suse.de> <45477131.4070501@google.com> <20061031174639.4d4d20e3@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031174639.4d4d20e3@gondolin.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 05:46:39PM +0100, Cornelia Huck wrote:
> On Tue, 31 Oct 2006 07:52:17 -0800,
> "Martin J. Bligh" <mbligh@google.com> wrote:
> 
> > >>> Merely change CONFIG_SYSFS_DEPRECATED to be set to yes, and it should
> > >>> all work just fine.  Doesn't anyone read the Kconfig help entries for
> > >>> new kernel options?
> > >> 1. This doesn't fix it.
> > > 
> > > I think acpi is now being fingered here, right?
> > 
> > Eh? How. Backing out all your patches from -mm fixes it.
> > The deprecated stuff does not fix it, it's the same as before.
> 
> That's because /sys/class/net/<interface> is now a symlink instead of a
> directory (and that hasn't anything to do with acpi, but rather with
> the conversions in the driver tree). Seems the directory -> symlink
> change shouldn't be done since it's impacting user space...

If you enable CONFIG_SYSFS_DEPRECATED, then there is no symlink and
there is no userspace change.  sysfs should look identical to before.

Or did I miss something doing this work?

thanks,

greg k-h
