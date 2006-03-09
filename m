Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbWCIADy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbWCIADy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWCIADy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:03:54 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:56556 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932616AbWCIADx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:03:53 -0500
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for
	2.6.16-rc5
From: Lee Revell <rlrevell@joe-job.com>
To: Greg KH <gregkh@suse.de>
Cc: bjdouma@xs4all.nl, Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
In-Reply-To: <20060308234004.GA31309@suse.de>
References: <20060306223545.GA20885@kroah.com>
	 <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de>
	 <20060308230519.GT4006@stusta.de> <1141859917.767.242.camel@mindpipe>
	 <20060308232350.GA26929@suse.de> <1141860895.767.251.camel@mindpipe>
	 <20060308234004.GA31309@suse.de>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 19:03:49 -0500
Message-Id: <1141862630.767.264.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 15:40 -0800, Greg KH wrote:
> On Wed, Mar 08, 2006 at 06:34:54PM -0500, Lee Revell wrote:
> > On Wed, 2006-03-08 at 15:23 -0800, Greg KH wrote:
> > > 
> > > > That should not go in 2.6.16 - it's not a hardware bug but a (poor IMHO)
> > > > design decision by the vendor.  And, it may break working setups when an
> > > > extra sound device shows up.
> > > 
> > > Ah, good thing I held off :)
> > > 
> > > Any objections to it going in for 2.6.17?
> > 
> > I can't think of a way to merge this and guarantee not to break
> > userspace unless it could be disabled by default.
> 
> Ok, how about you and Bauke (CCed, and the author of the patch) work
> together on the problem and let me know what you decide on.

The best option might be to just take a chance on breaking things - if
userspace is so fragile that an extra sound device appearing breaks
things, it could also be broken merely by adding a new driver to the
kernel.  If we have to worry about this kind of breakage the "no
incompatible changes" policy becomes "no new features".

That's my $0.02, it's between the patch author and the maintainer what
you want to do.

Lee

