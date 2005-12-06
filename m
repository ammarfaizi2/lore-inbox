Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbVLFKvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbVLFKvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbVLFKvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:51:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:45004 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751485AbVLFKvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:51:04 -0500
X-Authenticated: #428038
Date: Tue, 6 Dec 2005 11:51:02 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206105102.GC10574@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051203152339.GK31395@stusta.de> <20051203225020.GF25722@merlin.emma.line.org> <20051204002043.GA1879@kroah.com> <200512051647.55395.rob@landley.net> <20051205230502.GB12955@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205230502.GB12955@kvack.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2005, Benjamin LaHaise wrote:

> On Mon, Dec 05, 2005 at 04:47:55PM -0600, Rob Landley wrote:
> > So no in-kernel filesystem can get this right without help from userspace 
> > (even devfs had devfsd), and as soon as you've got a userspace daemon to tell 
> > the kernel who is who you might as well do the whole thing there, now that 
> > the kernel is exporting everyting _else_ we need to know via /sys 
> > and /sbin/hotplug.
> 
> /sbin/hotplug is suboptimal.  Even a pretty fast machine is slowed down 
> pretty significantly by the ~thousand fork and exec that take place during 
> startup.  For the most common devices -- common tty, pty, floppy, etc that 
> every system has, this is a plain waste of resources -- otherwise known as 
> bloat.

You mean that distro boot scripts now need to wait for 20 seconds until
hotplug has finally handled all the coldplug events so the script can
finally slap the IPv4 address onto the interface or start dhcpcd. :-)

-- 
Matthias Andree
