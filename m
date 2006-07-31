Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWGaKzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWGaKzT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWGaKzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:55:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28628 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751518AbWGaKzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:55:18 -0400
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       laurent.riffard@free.fr, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060730230033.cc4fc190.akpm@osdl.org>
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <44CCBBC7.3070801@free.fr> <20060731000359.GB23220@kroah.com>
	 <200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	 <20060731033757.GA13737@kroah.com> <20060730212227.175c844c.akpm@osdl.org>
	 <20060731043542.GA9919@kroah.com> <20060730215025.44292f9c.akpm@osdl.org>
	 <20060731051547.GB29058@kroah.com>  <20060730230033.cc4fc190.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jul 2006 12:14:12 +0100
Message-Id: <1154344452.7230.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-07-30 am 23:00 -0700, ysgrifennodd Andrew Morton:
> > > Are we going to stop doing this soon?
> > 
> > Not if we want to keep on making things better.  The real reason I made
> > these changes is to get power management working better.  We need to get
> > the devices into the proper place in the sysfs tree in order to handle
> > suspend/resume for classes of devices properly.  That's what Linus's
> > patch did, and now I'm moving the devices to allow it to really happen.
> > 
> 
> This sucks.  Do you know what machines we'll be breaking out there?  I
> sure don't.

Greg, this changeset should get ripped out and thrown away. Its wrong.
Its an API breakage and it is going to catch a lot of people. People
said at the kernel summit the sysfs had serious problems because of the
structure it exposes and you said you could use symlinks and the like to
work around it, or fix the code.

How about proving it or doing the work to make it possible rather than
continuing to break everything repeatedly.

Alan

