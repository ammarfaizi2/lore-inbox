Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTFKOtQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTFKOtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:49:16 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:12452 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262116AbTFKOtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:49:13 -0400
Date: Wed, 11 Jun 2003 17:02:46 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Joseph Fannin <jhf@rivenstone.net>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030611170246.A4187@ucw.cz>
References: <m2smqhqk4k.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m2smqhqk4k.fsf@p4.localdomain>; from petero2@telia.com on Wed, Jun 11, 2003 at 07:05:31AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 07:05:31AM +0200, Peter Osterlund wrote:
> [ I'm resending this because the previous message never showed up on
> the list. Maybe it was too big. ]
> 
> Hi!
> 
> Here is a driver for the Synaptics TouchPad for 2.5.70. It is largely
> based on the XFree86 driver. This driver operates the touchpad in
> absolute mode and emulates a three button mouse with two scroll
> wheels. Features include:
> 
> * Multi finger tapping.
> * Vertical and horizontal scrolling.
> * Edge scrolling during drag operations.
> * Palm detection.
> * Corner tapping.
> 
> The only major missing feature is runtime configuration of driver
> parameters. What is the best way to implement that?

sysfs, of course.

> I was thinking of
> sending EV_MSC events to the driver using the /dev/input/event*
> interface and define my own codes for the different driver parameters.

No, not that ... 

> The patch is available here:
> 
>         http://w1.894.telia.com/~u89404340/patches/synaptics_driver.patch
> 
> Comments?

IMO it should use ABS_ events and the relativization should be done in
the XFree86 driver. Other than that, it looks quite OK.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
