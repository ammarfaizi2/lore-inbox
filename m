Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVBFUbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVBFUbH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 15:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVBFUbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 15:31:07 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:14854 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261311AbVBFUbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 15:31:00 -0500
Date: Fri, 19 Jan 1996 21:38:30 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Dave Jones <davej@redhat.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Intel AGP support attaching to wrong PCI IDs
In-Reply-To: <20050206060839.GA19330@redhat.com>
Message-ID: <Pine.LNX.4.61L.9601192103120.4093@blysk.ds.pg.gda.pl>
References: <9e4733910502051745c25d6f@mail.gmail.com> <20050206040526.GA2908@redhat.com>
 <9e4733910502052158491b5ce3@mail.gmail.com> <20050206060839.GA19330@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Feb 2005, Dave Jones wrote:

> Another way forward (somewhat hacky in one sense, but a lot cleaner in another)
> would be to change the PCI code so that it'll load and init
> multiple drivers that claim to support the same PCI ID.

 That might actually be useful to support some weird hardware.  E.g. I 
have a single-function PCI device which reports as a graphics adapter 
(either VGA or other, depending on the configuration), but besides the 
actual graphics adapter the chip includes a frame grabber, an USB host 
controller, an Ethernet interface, an IEEE 1284 parallel port, an UART, an 
I2C controller and a PS/2 keybard/mouse controller. ;-)  All of these 
mapped with a single PCI BAR; the chip can also be configured for legacy 
mapping of some devices, like the PS/2 stuff.

  Maciej
