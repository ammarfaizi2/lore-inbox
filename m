Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbULHWPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbULHWPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 17:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbULHWPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 17:15:38 -0500
Received: from soundwarez.org ([217.160.171.123]:59334 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261392AbULHWOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 17:14:45 -0500
Subject: Re: [ANNOUNCE] udev 048 release
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
       Hotplug Devel <linux-hotplug-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041208220500.GA19187@kroah.com>
References: <20041208185856.GA26734@kroah.com>
	 <20041208192810.GA28374@kroah.com> <20041208194618.GA28810@kroah.com>
	 <Pine.LNX.4.61L.0412082238420.18542@rudy.mif.pg.gda.pl>
	 <20041208220500.GA19187@kroah.com>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 23:15:21 +0100
Message-Id: <1102544121.5987.130.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 14:05 -0800, Greg KH wrote:
> On Wed, Dec 08, 2004 at 10:56:27PM +0100, Tomasz K?oczko wrote:

> > Also after aplying this patches libsysfs/ subdirectory can be removed from 
> > udev source tree.
> 
> Will it still properly build with klibc?

This will not work at the moment, as we fake the getmntent() call in
libsysfs at compile time for the klibc build.

> I'm sure those who package up rpms of udev have dealt with this properly
> somehow.  For the rest of the world, I'd prefer to keep the current way.

I agree. It's much easier to tweak the udev sources to use a dynamic
linked libsysfs than the other way around.

Thanks,
Kay

