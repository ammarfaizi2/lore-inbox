Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271313AbTHRHoQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 03:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271317AbTHRHoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 03:44:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62980 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S271313AbTHRHoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 03:44:14 -0400
Date: Mon, 18 Aug 2003 08:44:11 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling cardbus devices monolithic doesn't work?
Message-ID: <20030818084411.A26743@flint.arm.linux.org.uk>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <200308172158.34498.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308172158.34498.rob@landley.net>; from rob@landley.net on Sun, Aug 17, 2003 at 09:58:34PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

echo $subject | sed s/cardbus/pcmcia/i

On Sun, Aug 17, 2003 at 09:58:34PM -0400, Rob Landley wrote:
> I'm easing my way into the 2.6.0-test series, and everything I've done so far 
> has been with monolithic kernels to minimize the number of fun new things 
> I've been playing with, and I just can't get the monolithic orinoco_cs to 
> find my new thinkpad's built-in wireless networking thingy.

You still need to use cardmgr to bind the driver to the device.
It seems to work for me here on SA11x0 platforms, and I'm not aware
of it breaking at any point in the 2.5 series.

While it is true that Cardbus devices plugged into cardbus slots do
not need cardmgr, PCMCIA devices still do.

> (P.S.  And while I'm at it, what's the relationship between orinoco_cs, 
> orinoco, and hermes?  The /proc/modules dependency tree thing says they're 
> using each other in a chain.  Probably true, just a bit odd, I thought.  
> Couldn't figure out which driver I needed, compiled all three, and it loaded 
> ALL of them.  Can't complain, the card works under 2.4.  This is just a 
> random "huh?")

IIRC hermes provides the low level interface to the device, orinoco
provides the interface between it and the network stack, and orinoco_cs
provides a bridge between the PCMCIA subsystem and orinoco.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

