Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265237AbRF0Q4j>; Wed, 27 Jun 2001 12:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265309AbRF0Q4a>; Wed, 27 Jun 2001 12:56:30 -0400
Received: from mail.aslab.com ([205.219.89.194]:3699 "EHLO mail.aslab.com")
	by vger.kernel.org with ESMTP id <S265237AbRF0Q4S>;
	Wed, 27 Jun 2001 12:56:18 -0400
Date: Wed, 27 Jun 2001 09:56:16 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: David Hinds <dhinds@sonic.net>
cc: Gunther Mayer <Gunther.Mayer@t-online.de>, linux-kernel@vger.kernel.org,
        dhinds@bolt.sonic.net
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
In-Reply-To: <20010627090351.A7443@sonic.net>
Message-ID: <Pine.LNX.4.04.10106270954500.21460-100000@mail.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It should be all devices that do not claim ATA-4/5 support.
I have to go back and look to see what the cut-off was that CFA agreed to
move forward off the dead docs.

Cheers,

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

On Wed, 27 Jun 2001, David Hinds wrote:

> On Wed, Jun 27, 2001 at 12:29:47AM -0700, Andre Hedrick wrote:
> > 
> > I can not help if you have a device that not compliant to the rules.
> > ATA-2 is OBSOLETED thus we forced (the NCITS Standards Body) the CFA
> > people to move to ATA-4 or ATA-5.
> > 
> > That device is enabling with its ablity to assert its device->host
> > interrupt regardless of the HOST...that is a bad device.
> > 
> > Send me the manufacturer and I will tear them apart for making a
> > non-compliant device.  Then figure out a way to de-assert the like
> > regardless if it exists without hang the rest of the driver.
> 
> I don't understand the ATA spec issue, but *every* PCMCIA ATA device I
> know of (including all SmartMedia, CompactFlash, etc) suffers from
> this problem.  It is not an isolated manufacturer.  As far as I know,
> the IDE driver has always had the problem that it may trigger
> interrupts before it installs a handler.  Are you saying that is only
> true of pre-ATA-4 devices, or only devices that deviate from the spec?
> 
> -- Dave
> 

