Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWIIIje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWIIIje (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 04:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWIIIje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 04:39:34 -0400
Received: from [88.208.93.65] ([88.208.93.65]:28943 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S932371AbWIIIjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 04:39:33 -0400
Date: Sat, 9 Sep 2006 10:39:32 +0200
From: Martin Mares <mj@ucw.cz>
To: Greg KH <gregkh@suse.de>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: State of the Linux PCI Subsystem for 2.6.18-rc6
Message-ID: <mj+md-20060909.082546.5026.albireo@ucw.cz>
References: <20060909081816.GA13058@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909081816.GA13058@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg!

> No other new PCI driver API changes are pending that I am aware of.  The
> PCI sort order change will affect some people's userspace ordering of
> network devices, restoring it to the proper 2.4 ordering.  It was never
> intended that this be broken, and since no one has noticed this for the
> past 3 years, it was not broken in a severe way.

Changing the device order in the middle of the 2.6 cycle doesn't sound
like a sane idea to me. Many people have changed their systems' configuration
to adapt to the 2.6 ordering and this patch would break their setups.
I have seen many such examples in my vicinity.

I believe that not breaking existing 2.6 setups is much more important
than keeping compatibility with 2.4 kernels, especially when the problem
is discovered after more than 2 years after release of the first 2.6.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
How do I type 'for i in *.dvi ; do xdvi $i ; done' in a GUI?
