Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVLKSZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVLKSZW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVLKSZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:25:22 -0500
Received: from mail.gmx.net ([213.165.64.21]:7639 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750777AbVLKSZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:25:06 -0500
X-Authenticated: #20799612
Date: Sun, 11 Dec 2005 19:20:37 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 0/9] isdn4linux: add drivers for Siemens Gigaset ISDN DECT PABX
Message-ID: <gigaset307x.2005.12.11.001.0@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SourceForge project http://sourceforge.net/projects/gigaset307x/
has, over the last four years, developed Linux support for the Siemens
Gigaset 3070/3075/4170/4175/SX205/SX255 family of ISDN DECT PABXes,
connected to a PC either directly via USB or over a DECT link using
the M101/M105 DECT data adapters.
The devices are integrated as ISDN adapters within the isdn4linux
framework, as well as providing access to device specific commands
through a tty device.

After much encouragement from the USB and isdn4linux maintainers, we
have decided to submit our drivers for inclusion in the kernel source
tree.

The patch set that follows adds three kernel modules:

- a common module "gigaset" encapsulating the common logic for
  controlling the PABX and the interfaces to userspace and the
  isdn4linux subsystem.

- a connection-specific module "bas_gigaset" which handles
  communication with the PABX over a direct USB connection.

- a connection-specific module "usb_gigaset" which does the same
  for a DECT connection using the Gigaset M105 USB DECT adapter.

We also have a module "ser_gigaset" which supports the Gigaset M101
RS232 DECT adapter, but we didn't judge it fit for inclusion in the
kernel, as it does direct programming of a i8250 serial port. It
should probably be rewritten as a serial line discipline but so far we
lack the neccessary knowledge about writing a line discipline for that.

The drivers have been working with kernel releases 2.2 and 2.4 as well
as 2.6, and although we took efforts to remove the compatibility code
for this submission, it probably still shows in places. Please make
allowances.

The patch has been split into 9 parts to comply to size limits.
All of the parts are designed to be applied together.
