Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264221AbTICUGV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbTICUEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:04:43 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11023 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264188AbTICUC7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:02:59 -0400
Date: Wed, 3 Sep 2003 15:54:11 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Blake B." <shadoi@nanovoid.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test 4 and USB
In-Reply-To: <bj4to7$i3p$1@sea.gmane.org>
Message-ID: <Pine.LNX.3.96.1030903154731.9300A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Blake B. wrote:

> watermodem wrote:
> > I forgot to note on the USB and CUPs problem that I see the USB tree 
> > under "/sys/bus/usb" where-as under /proc/bus/usb I see nothing.
> > This may break a lot of existing code... Is is suppose to be this way?
> > 
> > 
> > 
> 
> Read /linux-kernel-source/Documentation/usb/proc_usb_info.txt

I must be missing something, the mount command from that file doesn't
seem to solve the original poster's problem, the /proc/bus/usb is still
empty...

================================================================

>From root@oddball.prodigy.com Wed Sep  3 15:47:22 2003
Subject: USB proc stuff
From: root <root@oddball.prodigy.com>
Date: Wed, 3 Sep 2003 13:19:15 -0400
To: davidsen@tmr.com

oddball:root> mount -t usbfs none /proc/bus/usb
oddball:root> df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda3              2522076   2338380     55580  98% /
/dev/hda1                23302     20030      2069  91% /boot
/dev/hda5              1510032    265388   1167936  19% /home
/dev/hdb3              1474320    897712    501716  65% /usr/src
none                     46776         0     46776   0% /dev/shm
oddball:root> mount -t usbfs none /proc/bus/usb
mount: none already mounted or /proc/bus/usb busy
mount: according to mtab, none is already mounted on /proc/bus/usb
oddball:root> lc /proc/bus/usb
oddball:root> l -aR /proc/bus/usb
/proc/bus/usb:
total 0
drwxr-xr-x    2 root            0 Sep  3 13:17 .
dr-xr-xr-x    6 root            0 Sep  3 13:17 ..
oddball:root> lc /sys/b
block  bus
oddball:root> lc /sys/bus/usb/
devices/  drivers/
oddball:root>
================================================================

I did the mount, checked that it worked, and the data still seems
missing. Before you ask, lc is an alias for "ls -CF" and a leftover
reflex from a previous o/s.

I did drag and drop on the mount command from the file you quote, o/s is
2.4.0-test4 with only Nick's v7 scheduler patch.

