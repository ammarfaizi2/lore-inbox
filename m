Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265540AbUABR64 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 12:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265546AbUABR64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 12:58:56 -0500
Received: from quechua.inka.de ([193.197.184.2]:53986 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265540AbUABR6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 12:58:55 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: udev and devfs - The final word
Date: Fri, 02 Jan 2004 18:54:02 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing	moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2004.01.02.17.52.48.455285@dungeon.inka.de>
References: <20031231002942.GB2875@kroah.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003 00:32:58 +0000, Greg KH wrote:
> The Problems:
>  1) A static /dev is unwieldy and big.  It would be nice to only show
>     the /dev entries for the devices we actually have running in the
>     system.

last time i checked, devices for physical resources are only a part
of the devices in /dev. the other big part are those devices for
virtual resources, like virtual master/slave tty, network block devices,
loop devices, virtual consoles, etc.

neither devfs nor udev handle the virtual part. only devpts does, 
and only for one special class of virtual devices. and usb devices
are neither handled by devfs nor udev, but by usbfs.

Actually udev is a regression:
 - devfs was a first efford at a sane /dev naming policy, udev returns to
   the old and cryptic lsb device naming.
 - devfs made makedev obsolete, udev doesn't work without it / can
   currently not create all devices because of missing sysfs support.

Ignore this mail if you want, but people might be unhappy with udev
because of these regressions and not caring about it will not improve
the situation.

Andreas

