Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269631AbRHADj0>; Tue, 31 Jul 2001 23:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269624AbRHADjQ>; Tue, 31 Jul 2001 23:39:16 -0400
Received: from ns3.keyaccesstech.com ([209.47.245.85]:26892 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S269622AbRHADjD>; Tue, 31 Jul 2001 23:39:03 -0400
Date: Tue, 31 Jul 2001 23:39:11 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <m18zh4zcq5.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0107312336280.15064-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 31 Jul 2001, Eric W. Biederman wrote:

> Russell King <rmk@arm.linux.org.uk> writes:
>
> > No.  Console initialisation is done early, before PCI is setup.  This
> > means that the serial driver is relying on a static array of IO port
> > addresses.  At this time, the serial driver hasn't probed any ports at
> > all, so it doesn't really know what does and doesn't exist.
>
> Hmm. I hadn't realized it was poking in the dark.

At least some PCI serial cards are just UARTs at a specific I/O address and
interrupt, and the I/O adress and interrupt are (more or less) constant each
boot. Could the values of these be passed to the kernel via command-line?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

