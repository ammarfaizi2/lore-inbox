Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311068AbSCMT03>; Wed, 13 Mar 2002 14:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311059AbSCMT0U>; Wed, 13 Mar 2002 14:26:20 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:25354
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311068AbSCMT0I>; Wed, 13 Mar 2002 14:26:08 -0500
Date: Wed, 13 Mar 2002 11:11:32 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Bill Davidsen <davidsen@tmr.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7 
In-Reply-To: <200203131842.g2DIgjtb024607@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.10.10203131053550.19703-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Horst von Brand wrote:

> Jeff Garzik <jgarzik@mandrakesoft.com>
> 
> [...]
> 
> > I -do- know the distrinction between hosts and devices.  I think there 
> > should be -some- way, I don't care how, to filter out those unknown 
> > commands (which may be perfectly valid for a small subset of special IBM 
> > drives).  The net stack lets me do filtering, I want to sell you on the 
> > idea of letting the ATA stack do the same thing.
> 
> The net stack does filtering for handling traffic from _untrusted_ external
> sources, either for local consumtion or as a service for dumb machines
> downstream, and as a way of limiting outward access to _untrusted_
> users. Here we are talking of the ultimate _trusted_ user (root,
> CAP_SYS_RAWIO, whatever). It makes no sense for the _kernel_ to get in the
> way. Create a userland proggie for prodding IDE drives, and give it ways to
> check (as far as terminal paranoia demands, a little, or not at all) as
> desired. Unix ultimate simplicity is all about giving root enough rope to
> shoot at his own feet.


Greetings Dr. von Brand,

One of the issues that has been confused in the stack is the command
parser and/or sequencer.  It is used internally to allow quick and rapid
command additions as needed.  Most are not clear how the IOCTL works and
thinks it runs via the command parser, this is totally wrong.  The sad
part is the lenght of the rope does not hit the feet, it hits the head.

Regards,

Andre Hedrick

