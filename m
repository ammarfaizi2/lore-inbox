Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbTIOQHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTIOQHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:07:13 -0400
Received: from arces.unibo.it ([137.204.143.6]:13495 "EHLO arces.unibo.it")
	by vger.kernel.org with ESMTP id S261495AbTIOQHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:07:09 -0400
From: "Nicola Frignani" <nfrignani@arces.unibo.it>
To: "Kernel mailinglist" <linux-kernel@vger.kernel.org>
Subject: /dev/root
Date: Mon, 15 Sep 2003 17:07:10 +0100
Message-Id: <20030915160710.M65258@arces.unibo.it>
X-Mailer: Open WebMail 1.71 20020829
X-OriginatingIP: 137.204.143.2 (nfrignani)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-RAVMilter-Version: 8.4.4(snapshot 20030410) (mail.arces.unibo.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've a 2.4.19 kernel and it works well producing in mtab

rootfs on / type rootfs (rw)
/dev/root on / type auto (rw)

when i recompile 2.4.22 evreything goes right but in /etc/lilo.conf i found

~~~old
image=/boot/vmlinuz-2.4.19-16mdk-23.12.2002
	label=2419NF-23.12.02
	root=/dev/sda1
	read-only
	optional
	vga=normal
	append=" devfs=mount hda=ide-scsi hdb=ide-scsi hdc=ide-scsi"
	initrd=/boot/initrd-2.4.19-16mdk-23.12.2002.img
~~~new
image=/boot/vmlinuz-2.4.22NF-09.03
	label=2422NF-0903
	root=#/dev/root
	read-only
	optional
	vga=normal
	append=" devfs=mount hda=ide-scsi hdb=ide-scsi hdc=ide-scsi"
	initrd=/boot/initrd-2.4.22NF-09.03.img

if i correct root=#/dev/root to root=/dev/sda1 to linuxbox goes to kernel
panic at the boot giving this error

kmod: failed to exec /sbin/modprobe -k -s auto , errno = 2
kmod: failed to exec /sbin/modprobe -k -s freeauto , errno = 2


if i compile the same kernel configuration to an exactly copy of this machine
it works correctly, but in the other the mtab gives

/dev/sda1 on / type ext3 (rw)


what's wrong?

thanks all

-- 
Nicola Frignani 
nfrignani@arces.unibo.it 
051-2095432 
