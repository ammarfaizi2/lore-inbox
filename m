Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbUCOWk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbUCOWkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:40:25 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:481 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262828AbUCOWkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:40:17 -0500
Date: Mon, 15 Mar 2004 22:39:57 +0000
From: Dave Jones <davej@redhat.com>
To: Oliver Vogel <oliver.vogel@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.4 - Card Reader not working
Message-ID: <20040315223957.GC19555@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Oliver Vogel <oliver.vogel@gmx.net>, linux-kernel@vger.kernel.org
References: <20040315233106.28bc8b7a.oliver.vogel@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315233106.28bc8b7a.oliver.vogel@gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 11:31:06PM +0100, Oliver Vogel wrote:
 > Hello everybody!
 > 
 > I got a little problem with a Memory Card Reader under Linux 2.6.4.
 > 
 > I enabled usb (both ehci and uhci) support, usb storage support in the
 > kernel, as well as scsi support and scsi disk support.
 > Mounting usb sticks works well, also the Card Reader shows at lsusb (see
 > below).
 > Also, there is a device /dev/sda (or rather
 > /dev/scsi/host0/bus0/target0/lun0/disc, I'm using devfs), but when I
 > insert an SD card into the reader, there is no sda1 (or rather target1)
 > appearing.
 > I also tried enabling probe all LUNs, with the result that the device
 > didn't appear in lsusb anymore.
 > 
 > I already asked in a Linux hardware newsgroup, but nobody seems to have
 > a clue...
 > 
 > Any hints?

I had a similar problem recently with a 6-in-1 reader I picked up.
Using..
modprobe scsi_mod max_luns=6

it could see all LUNs on the device (each slot was a seperate LUN).

If this works for you, send the scsi messages from dmesg output, and
it can be added to the list of devices to probe all luns.

		Dave

