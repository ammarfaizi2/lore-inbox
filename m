Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280718AbRKOE0S>; Wed, 14 Nov 2001 23:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280740AbRKOE0I>; Wed, 14 Nov 2001 23:26:08 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:30981 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280718AbRKOEZ6>;
	Wed, 14 Nov 2001 23:25:58 -0500
Date: Wed, 14 Nov 2001 21:24:41 -0800
From: Greg KH <greg@kroah.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] races in access to pci_devices
Message-ID: <20011114212441.B8285@kroah.com>
In-Reply-To: <Pine.GSO.4.21.0111142257510.1095-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0111142257510.1095-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 18 Oct 2001 04:03:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 11:00:26PM -0500, Alexander Viro wrote:
> 	Linus, as far as I can see there's no exclusion between
> the code that walks pci_devices and pci_insert_device().  It's
> not a big deal wrt security (not many laptops with remote access)
> but...

It's a bigger deal with large servers that have PCI Hotplug controllers.

> 	What locking is supposed to be there?

I'll add a lock to keep the problem from happening.

thanks,

greg k-h
