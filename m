Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946406AbWKACJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946406AbWKACJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946405AbWKACJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:09:27 -0500
Received: from ns1.suse.de ([195.135.220.2]:52965 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946408AbWKACJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:09:26 -0500
Date: Tue, 31 Oct 2006 18:08:50 -0800
From: Greg KH <gregkh@suse.de>
To: Martin Bligh <mbligh@google.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Mike Galbraith <efault@gmx.de>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-ID: <20061101020850.GA13070@suse.de>
References: <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com> <20061031065912.GA13465@suse.de> <4546FB79.1060607@google.com> <20061031075825.GA8913@suse.de> <45477131.4070501@google.com> <20061031174639.4d4d20e3@gondolin.boeblingen.de.ibm.com> <4547833C.5040302@google.com> <20061031182919.3a15b25a@gondolin.boeblingen.de.ibm.com> <4547FABE.502@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4547FABE.502@google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 05:39:10PM -0800, Martin Bligh wrote:
> Cornelia Huck wrote:
> >On Tue, 31 Oct 2006 09:09:16 -0800,
> >"Martin J. Bligh" <mbligh@google.com> wrote:
> >
> >
> >>Cornelia Huck wrote:
> >>
> >>>That's because /sys/class/net/<interface> is now a symlink instead of a
> >>>directory (and that hasn't anything to do with acpi, but rather with
> >>>the conversions in the driver tree). Seems the directory -> symlink
> >>>change shouldn't be done since it's impacting user space...
> >>
> >>You know which individual patch in -mm broke that? Can't see it easily.
> >>Then we can just test across all the machines with just that one backed
> >>out.
> >
> >
> >I'd try reverting gregkh-driver-network-device.patch for the network
> >device stuff.
> 
> Reverting that patch does indeed appear to fix it.

Even with CONFIG_SYSFS_DEPRECATED enabled?  For some reason I'm guessing
that you missed that suggestion a while back...

thanks,

greg k-h
