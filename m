Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264334AbRFMCxr>; Tue, 12 Jun 2001 22:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264346AbRFMCxh>; Tue, 12 Jun 2001 22:53:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:16388 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264334AbRFMCxU>; Tue, 12 Jun 2001 22:53:20 -0400
Date: Tue, 12 Jun 2001 19:49:30 -0700 (PDT)
From: Patrick Mochel <mochel@transmeta.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.6-pre3 
In-Reply-To: <26832.992400011@ocs4.ocs-net>
Message-ID: <Pine.LNX.4.10.10106121944470.13607-100000@nobelium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Jun 2001, Keith Owens wrote:

> On Tue, 12 Jun 2001 18:42:45 -0700 (PDT), 
> Linus Torvalds <torvalds@transmeta.com> wrote:
> >-pre3:
> > - Jeff Garzik: network driver updates
> 
> tulip_core.c:1756: warning: initialization from incompatible pointer type
> tulip_core.c:1757: warning: initialization from incompatible pointer type

This is likely due to the updates to struct pci_driver.

The suspend callback was changed to take another parameter (the state it
is to enter) and to return an int.

The resume callback was changed to return an int.

Since these callbacks are rarely, if ever used, and since they don't
cause an actual compile error, the changes were considered benign.

	-pat

