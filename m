Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTL2VUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 16:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTL2VUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 16:20:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:44007 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264265AbTL2VUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 16:20:34 -0500
Date: Mon, 29 Dec 2003 13:14:25 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Wakko Warner <wakko@animx.eu.org>
Cc: szepe@pinerecords.com, clock@twibright.com, linux-kernel@vger.kernel.org
Subject: Re: Can't mount USB partition as root
Message-Id: <20031229131425.3d3042e0.rddunlap@osdl.org>
In-Reply-To: <20031229133812.A4788@animx.eu.org>
References: <20031229173853.A32038@beton.cybernet.src>
	<20031229164539.GD30794@louise.pinerecords.com>
	<20031229133812.A4788@animx.eu.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003 13:38:12 -0500 Wakko Warner <wakko@animx.eu.org> wrote:

| > > Is it possible to boot kernel with root from /dev/sda1 (USB)?
| > > partition table: whole /dev/sda is one partition (sda1), type 83 (Linux).
| > > Tried also switching on and off hotplugging in kernel and it didn't help.
| > 
| > Well, is the device detected and the partition table scanned before the
| > root mount is attempted?
| > 
| > I believe this should work given you've compiled in all the necessary
| > code.  Please capture the dmesg using serial console/netconsole/whatever
| > and post it along with your .config.
| 
| I did this with 2.4 a few months back.  Basically all I did was add the same
| delay before mounting root as the kernel does with mounting a root floppy. 
| Problem is the kernel is too fast for the usb code to find the disk.
| 
| I'v been wanting to ask this question.  How can I make the kernel "sleep"
| for say 5 seconds (or pause or something, whatever is required to delay
| execution) to wait for the device to become available.  I tried the same
| thing doing nfsroot with a cardbus nic which fails because the kernel
| doesn't see the card until after it attempted to mount /

I posted a patch for 2.4.22 which someone tested and reported as working.
The patch is here:
  http://www.xenotime.net/linux/usb/usbboot-2422.patch

--
~Randy
