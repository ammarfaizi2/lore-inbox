Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVHFFZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVHFFZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 01:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVHFFZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 01:25:59 -0400
Received: from palrel10.hp.com ([156.153.255.245]:26323 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261448AbVHFFZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 01:25:58 -0400
Date: Fri, 5 Aug 2005 22:29:21 -0700
From: Grant Grundler <iod00d@hp.com>
To: Greg KH <gregkh@suse.de>
Cc: yhlu <yhlu.kernel@gmail.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>, linville@tuxdriver.com,
       openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [openib-general] Re: mthca and LinuxBIOS
Message-ID: <20050806052921.GC27352@esmail.cup.hp.com>
References: <86802c4405080511079d01532@mail.gmail.com> <52psss5k1x.fsf@cisco.com> <86802c44050805112661d889aa@mail.gmail.com> <86802c4405080512254b9cd496@mail.gmail.com> <86802c4405080512451cdcae48@mail.gmail.com> <86802c44050805132853070f1@mail.gmail.com> <Pine.LNX.4.58.0508051335440.3258@g5.osdl.org> <20050805220015.GA3524@suse.de> <86802c4405080515257ddaa8d2@mail.gmail.com> <20050805230300.GA4363@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805230300.GA4363@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 04:03:00PM -0700, Greg KH wrote:
...
> > yesterday, someone add pci_restore_bars...., that will call
> > pci_update_resource, and it will overwirte upper 32 bit of BAR2 and
> > BAR4 of IB card.
> 
> Hm, perhaps that change should not do this?
> 
> Dominik, care to weigh in here?  That was your patch...

Was the origin of this patch the following thread started
by John Linville:
	http://lkml.org/lkml/2005/6/23/257

I pointed out it would have issues with 64-bit BARs.
And I suggested some solutions to JohnL's patch here:
	http://lkml.org/lkml/2005/7/2/14

In any case same issues apply to pci_update_resource().

grant
