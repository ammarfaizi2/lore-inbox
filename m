Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbTFRTjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 15:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbTFRTjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 15:39:09 -0400
Received: from fmr03.intel.com ([143.183.121.5]:18938 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S265080AbTFRTjG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 15:39:06 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780DD16BE3@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'viro@parcelfarce.linux.theplanet.co.uk'" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Alan Stern'" <stern@rowland.harvard.edu>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Russell King'" <rmk@arm.linux.org.uk>, "'Greg KH'" <greg@kroah.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Flaw in the driver-model implementation of attributes
Date: Wed, 18 Jun 2003 12:52:57 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: viro@parcelfarce.linux.theplanet.co.uk
[mailto:viro@parcelfarce.linux.theplanet.co.uk]
> 
> > So what? _every_ block device will have some form of physical
> > back-up that can be linked back into sysfs.
> 
> ... except ones that will not.  Wonderful.  I bow to that logics - there
> is nothing it wouldn't cover.

Thank you }:) - we like it or not, data goes somewhere.

> > In the tree structure it makes sense, because each block
> > device, at the end is or a partition (and thus is embedded
> > in a "true" block device) or a true block device on a 1:1
> > relationship with a physical device.
> 
> BS.  There is nothing to stop you from having a block device that talks
> to userland process instead of any form of hardware.  As the matter of
> fact, we already have such a beast - nbd.  There is also RAID - where

Sure, there: /sys/devices/"virtual"/nbd/0

> there fsck is 1:1 here?  There's also such thing as RAID5 over partitions
> that sit on several disks - where do you see 1:1 or 1:n or n:1?

/sys/devices/"virtual"/raid/0

> There is such thing as e.g. encrypted loop over NFS.  There are all
> sorts of interesting things, with all sorts of interesting relationship
> to some pieces of hardware.

/sys/devices/"virtual"/loopback/0

Don't you have to do "-o loop" when you mount a loopback?
... same thing happens with nbd and RAID, you have to 
tell the kernel to create the actual devices (or it 
does); that they show up nowhere in sysfs (yet) is different.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
