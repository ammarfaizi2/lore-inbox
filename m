Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274982AbTHRTev (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274990AbTHRTev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:34:51 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:54691
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S274982AbTHRTet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:34:49 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Compiling cardbus devices monolithic doesn't work?
Date: Mon, 18 Aug 2003 15:34:37 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200308172158.34498.rob@landley.net> <20030818084411.A26743@flint.arm.linux.org.uk>
In-Reply-To: <20030818084411.A26743@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308181534.37586.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahem, second attempt:

On Monday 18 August 2003 03:44, Russell King wrote:

> You still need to use cardmgr to bind the driver to the device.
> It seems to work for me here on SA11x0 platforms, and I'm not aware
> of it breaking at any point in the 2.5 series.
>
> While it is true that Cardbus devices plugged into cardbus slots do
> not need cardmgr, PCMCIA devices still do.

The hotplug scripts from RH9 are there and seem happy, I thought cardmgr was 
called from them.  (The same setup works in 2.4.21, albeit with modules 
enabled.  I should compile a monolithic 2.4 kernel and see what it does...)

> > (P.S.  And while I'm at it, what's the relationship between orinoco_cs,
> > orinoco, and hermes?  The /proc/modules dependency tree thing says
> > they're using each other in a chain.  Probably true, just a bit odd, I
> > thought. Couldn't figure out which driver I needed, compiled all three,
> > and it loaded ALL of them.  Can't complain, the card works under 2.4. 
> > This is just a random "huh?")
>
> IIRC hermes provides the low level interface to the device, orinoco
> provides the interface between it and the network stack, and orinoco_cs
> provides a bridge between the PCMCIA subsystem and orinoco.

Now I'm confused.  I thought the _cs on the end was short for "cardbus"...

Rob
