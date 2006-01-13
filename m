Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWAMBss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWAMBss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 20:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWAMBsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 20:48:47 -0500
Received: from rtlab.med.cornell.edu ([140.251.49.13]:26262 "EHLO
	openlab.rtlab.org") by vger.kernel.org with ESMTP id S964936AbWAMBsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 20:48:47 -0500
Date: Thu, 12 Jan 2006 20:48:43 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: calin@rtlab.med.cornell.edu
To: linux-kernel@vger.kernel.org
Subject: SBC: Winsystems EPX-C3 Watchdog Timer?
Message-ID: <Pine.LNX.4.64.0601122044190.9231@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I wanted to see if a driver for the watchdog timer built into the 
Winsystems EPX-C3 SBC board is something the linux kernel people are 
interested in.  If so, how should I structure the driver if I were to 
submit it?

The reason I ask is that this board's watchdog is pretty basic/primitive. 
It is not a PCI device, it doesn't have any status registers per se and is 
configured by jumpers on the board only.

Behavior of the watchdog (if configured):

Enable the watchdog:  Write a 1 to io address: 0x1EE
Pet the watchdog before the timeout period (1.5s or 200s depending on 
jumper config): Write any value to io address: 0x1EF
Disable the watchdog: Write a 0 to io address: 0x1EE.

Pretty basic huh?  As such -- there is no way to tell in software if the 
watchdog exists, if it is enabled, or how long the timeout is.  Since this 
is so basic.. does it belong in the mainline kernel?  Or should it best be 
done as a userspace program instead?

Any guidance is appreciated..

-Calin


