Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVF2C1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVF2C1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVF2C1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 22:27:25 -0400
Received: from free.hands.com ([83.142.228.128]:46497 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S262260AbVF2CYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 22:24:48 -0400
Date: Wed, 29 Jun 2005 03:33:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] accessing loopback filesystem+partitions on a file
Message-ID: <20050629023331.GC10219@lkcl.net>
References: <20050628234917.GE9087@lkcl.net> <200506290233.05922.mark.williamson@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506290233.05922.mark.williamson@cl.cam.ac.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EXCELLENT.  thank you.

On Wed, Jun 29, 2005 at 02:33:05AM +0100, Mark Williamson wrote:
> > 	i'm sort-of helping test a xen install project where a
> > 	block device is presented as the DRIVE - not, i repeat
> > 	not, the partitions on the drive which is the quotes
> > 	normal quotes way of doing xen installes
> >
> > 	(yes there are good reasons for doing this).
> 
> That's fine.  It's something that (is supposed to) works.
 
 yep.  it does.

> > 	* how the hell do you loopback mount (or lvm mount
> > 	  or _anything_! something!)  partitions that have
> > 	  been created in a loopback'd file!!!!
> 
> 
> You could work out where the partitions are, then use hexedit... woops!  just 
> kidding ;-)
> 
> This has come up before but it's easier to find the list entries when you 
> remember what you're looking for ;-)
> 
> There's a patch by NASA (of all people!) that enables the Linux loopback 
> driver to support partitions:
> ftp://ftp.hq.nasa.gov/pub/ig/ccd/enhanced_loopback/readme.txt

 *curious* - why haven't these mods been merged back yet?

> There's also the "lomount" utility from QEmu:
> http://www.dad-answers.com/qemu/utilities/QEMU-HD-Mounter/lomount/
> Which works out where partitions are and mounts them (no kernel mods needed).

 _great_.

> Apparently kpartx (from the multipath tools - 
> http://christophe.varoqui.free.fr/wiki/wakka.php?wiki=Home) can use the 
> device mapper to create block devices for each partition.
> 
> I think I'd go with lomount, as it looks easiest.

 
 okay.

 question for you.

 would there be any reason (e.g. performance increase)
 which could justify providing the block device remapping
 facility at the linux device driver level instead of in
 xen's fun-and-games?

 the non-technical (but aesthetic) justification is that
 xen provides the facility to represent block devices
 (major+minor) for use as generic block devices _anyway_ -
 just in a rather roundabout (and exclusionary i.e.
 "unfair!! i wanna play!!") manner.

 l.

 p.s. mark, what the hell are _you_ doing up at 3am??? :)

