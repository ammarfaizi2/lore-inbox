Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130520AbRBNRzF>; Wed, 14 Feb 2001 12:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130530AbRBNRyz>; Wed, 14 Feb 2001 12:54:55 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:19805 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130520AbRBNRyh>; Wed, 14 Feb 2001 12:54:37 -0500
Date: Wed, 14 Feb 2001 11:54:26 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: David Hinds <dhinds@sonic.net>
cc: Andrew Morton <andrewm@uow.edu.au>,
        Manfred Spraul <manfred@colorfullife.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] network driver updates
In-Reply-To: <20010214093859.B20503@sonic.net>
Message-ID: <Pine.LNX.3.96.1010214115402.6565B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, David Hinds wrote:
> On Thu, Feb 15, 2001 at 12:33:43AM +1100, Andrew Morton wrote:
> > 
> > > * something is wrong in the vortex initialization: I don't have such a
> > > card, but the driver didn't return an error message on insmod. I'm not
> > > sure if my fix is correct.
> > 
> > That was intentional - dhinds suggested that if the hardware
> > isn't present the driver should float about in memory anyway.
> 
> Say the driver is linked into the kernel.  Hot plug drivers should not
> all complain about not finding their hardware.

Yes; that is the whole reason why pci_register_driver does not error out
when it finds zero matching devices.

	Jeff




