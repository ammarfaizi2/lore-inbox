Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVEWVmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVEWVmB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 17:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVEWVmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 17:42:01 -0400
Received: from w002.z065106067.sjc-ca.dsl.cnc.net ([65.106.67.2]:39846 "EHLO
	smtp.mail-test.us") by vger.kernel.org with ESMTP id S261977AbVEWVl5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 17:41:57 -0400
Message-ID: <42924E38.7070003@mail-test.us>
Date: Mon, 23 May 2005 14:42:16 -0700
From: Chris Haumesser <chris@mail-test.us>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050328)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: promise sx8 sata driver
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope this isn't entirely inappropriate for this list, but I am trying
to learn more about the promise sx8 driver in the current 2.6-series
kernel. 

I'm currently running debian-sarge with a custom 2.6.11.10 kernel.

The sx8 driver does not use libata, and it is a separate block device,
outside of the scsi and ata hierarchies.  If I compile the driver into
my kernel, I end up with /dev/sx8/0 and /dev/sx8/0p1, etc.  However, no
scsi disk devices are created, and grub does not recognize that
/dev/sx8/ devices are disks.  There's no indication in /proc/scsi/ that
they are being registered with the scsi subsystem; this is clearly
different from every other sata controller I've used.  I've been
googling this for days, with no real luck.  I have found changelogs for
grub that suggest that my version (0.95) should support booting from the
sx8.

So my question is, how does one use this driver for sata disks?  Is my
problem a grub problem, or does it have something to do with the fact
that this is a separate block device from the ata/scsi subsystems?

There is a different open source driver directly available from promise,
which seems to work better for my needs; however, I would like to be
able to have the driver built directly into the kernel rather than
modularized.  When I insert the SATAIIS150.ko kernel module from this
driver, dmesg immediately shows my disks; they are assigned standard
scsi device nodes (sda, sdb, etc); and they are recognized by grub. 

What is the relationship between the promise driver and the one included
in the kernel?  Why does one work differently from the other?  Is there
something else I need to activate in my kernel configuration to get the
standard 2.6 kernel driver to work the way I expect?

I hope someone can shed some light.  I can't seem to find any
documentation or info anywhere.


Many thanks,


-C-

