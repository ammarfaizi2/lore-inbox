Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUAZWRl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265353AbUAZWRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:17:41 -0500
Received: from mother.ds.pg.gda.pl ([153.19.213.213]:23027 "HELO
	mother.ds.pg.gda.pl") by vger.kernel.org with SMTP id S265236AbUAZWRj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:17:39 -0500
Date: Mon, 26 Jan 2004 23:15:39 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: LKML <linux-kernel@vger.redhat.com>
Subject: Re: [ANNOUNCE] udev 015 release
Message-ID: <20040126221539.GA27377@irc.pl>
References: <20040126215036.GA6906@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040126215036.GA6906@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 01:50:36PM -0800, Greg KH wrote:
> I've released the 015 version of udev.  It can be found at:

 Great, 15 minuts after I've installed 014 ;-)

014 and 015 errors for me when made with 'make USE_DBUS=true':

udev_dbus.c: In function `sysbus_connect':
udev_dbus.c:41: warning: implicit declaration of function `dbg'
gcc  -ldbus-1   -o udev  udev.o udev_config.o udev-add.o udev-remove.o \
 udevdb.o logging.o namedev.o namedev_parse.o /mnt/ram/udev-015/libsysfs/sysfs_bus.o \
 /mnt/ram/udev-015/libsysfs/sysfs_class.o /mnt/ram/udev-015/libsysfs/sysfs_device.o \
 /mnt/ram/udev-015/libsysfs/sysfs_dir.o /mnt/ram/udev-015/libsysfs/sysfs_driver.o \
 /mnt/ram/udev-015/libsysfs/sysfs_utils.o /mnt/ram/udev-015/libsysfs/dlist.o \
 tdb/tdb.o tdb/spinlock.o udev_dbus.o -lc 
udev_dbus.o(.text+0x49): In function `sysbus_connect':
: undefined reference to `dbg'
udev_dbus.o(.text+0x11f): In function `sysbus_send_create':
: undefined reference to `dbg'
udev_dbus.o(.text+0x1ce): In function `sysbus_send_remove':
: undefined reference to `dbg'
collect2: ld returned 1 exit status
make: *** [udev] Error 1

(manually wrapped line with gcc in above log).
Thats with dbus-0.20 installed.

-- 
Tomasz Torcz              Elvis Presley nie ¿yje. Winni s± developerzy Debiana.
zdzichu@irc.-nie.spam-.pl         -- marcoos w komentarzach na infojama.pl
|> Playing:  - Radio 103,4 Blue FM : Najlepiej Dobrana Muzyka prosto z Poznania
