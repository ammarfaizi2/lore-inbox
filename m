Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTJJBjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 21:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTJJBjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 21:39:02 -0400
Received: from ozlabs.org ([203.10.76.45]:1482 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262714AbTJJBi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 21:38:59 -0400
Date: Fri, 10 Oct 2003 11:38:34 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: David Ford <david+powerix@blue-labs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems w/ 2.6.0-test5 and orinocco device
Message-ID: <20031010013834.GG6588@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	David Ford <david+powerix@blue-labs.org>,
	linux-kernel@vger.kernel.org
References: <3F6C6F75.3020607@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6C6F75.3020607@blue-labs.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 20, 2003 at 11:17:09AM -0400, David Ford wrote:
> In short, I can bring up dev eth2 which is a wireless net card 
> (orinocco), but if I bring it down, it breaks.  I can't do anything with 
> it anymore; I have to reboot before I can use it again.  This didn't 
> happen in -test4.  Once in a while in -test4 and below it did break but 
> broke differently.  Mail me if you want details on it.

Sorry I've taken a while to reply - I've had other things on my plate
and not much time for orinoco work.  Any details you have would be
useful.

In particular any error messages would be handy - since the crash
might prevent them getting to syslog, try switching to a text console
and running "dmesg -n 8" to request that all messages, including debug
level ones go to the console immediately.  Then trigger the bug and
see if any messages appear on the console.

> orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> orinoco_plx.c 0.13e (Daniel Barlow <dan@telent.net>, David Gibson 
> <hermes@gibson.dropbear.id.au>)
> 
> eth2: Station identity 001f:0001:0008:000a
> eth2: Looks like a Lucent/Agere firmware version 8.10
> eth2: Ad-hoc demo mode supported
> eth2: IEEE standard IBSS ad-hoc mode supported
> eth2: WEP supported, 104-bit key
> eth2: MAC address 00:02:2D:5C:18:9F
> eth2: Station name "HERMES I"
> eth2: ready
> eth2: index 0x01: Vcc 3.3, irq 9, io 0x0100-0x013f
> eth2: New link status: Connected (0001)
> spurious 8259A interrupt: IRQ7.
> eth2: New link status: AP Out of Range (0004)
> eth2: New link status: AP In Range (0005)
> 
> 

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
