Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269467AbUJLFyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269467AbUJLFyV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 01:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269468AbUJLFyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 01:54:21 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:4741 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S269467AbUJLFyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 01:54:19 -0400
Date: Tue, 12 Oct 2004 07:54:18 +0200
From: bert hubert <ahu@ds9a.nl>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc4] USB && mass-storage && disconnect broken semantics
Message-ID: <20041012055418.GA26074@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Kay Sievers <kay.sievers@vrfy.org>, Greg KH <greg@kroah.com>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20041011120701.GA824@outpost.ds9a.nl> <20041011153719.GA4118@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011153719.GA4118@vrfy.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 05:37:19PM +0200, Kay Sievers wrote:

> > The expected behaviour is that on forceably unplugging an USB memory stick,
> > the created SCSI device should vanish, along with the mounts based on it.
> 
> That is clearly bejond the scope of the kernel or hotplug. This policy
> belongs to some other device management software. We are currently working on
> HAL as one example, to make that happen.

There is no way for userspace to do this. I thank you for your kneejerk 'it
is a userspace problem' report though - somebody has to do it.

Not very productive however. The kernel does not perform minimal services,
and gets confused to boot.

Now I'm all for offloading hotplug &c to userspace but when a device is
gone, people expect the associated devices to vanish as well, not linger
around generating invisible errors in dmesg.

> Yes, we need to make the unplug of mounted devices more safe, especially
> with sync mount, but don't expect the kernel or hotplug to do anything
> like that. It's up to some policy software higher in the stack.

Pray tell how I can do this from 'higher in the stack'. At least something
needs to happen, because now there is the possibility of lingering devices,
and I'm pretty sure we could get un-umountable mounts pointing there.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
