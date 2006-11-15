Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966767AbWKOKsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966767AbWKOKsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966770AbWKOKsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:48:23 -0500
Received: from server1.meinberg.de ([85.10.202.66]:3476 "EHLO
	paolo.meinberg.de") by vger.kernel.org with ESMTP id S966767AbWKOKsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:48:22 -0500
Message-ID: <455AF068.5020700@meinberg.de>
Date: Wed, 15 Nov 2006 11:48:08 +0100
From: Heiko Gerstung <heiko.gerstung@meinberg.de>
Organization: Meinberg Radio Clocks
User-Agent: Thunderbird 1.5.0.7 (X11/20061108)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Initial ramdisk support does not work (for me) on 2.6.17.13
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

We are building embedded devices based on Linux and we use a ramdisk as
our root device in order to avoid problems with people switching off the
unit without a proper shutdown and to save write-cycles on our flash disc.

Using a 2.6.12 kernel it was no problem to boot the system by using this
kernel parameters:
load_ramdisk=1 console=tty0 initrd=initrd.gz rw  vga=769
ramdisk_size=32768 root=/dev/ram0

Today I tried to test run a 2.6.17.12 kernel using the same parameters
but I get this error message:
VFS: Cannot open root device "ram0" or unknown-block(1,0)
Please append a correct "root=" boot option

The RAMDISK driver seems to be initialized correctly and the initrd
image (gzipped ext2fs) contains a block device /dev/ram0 with major 1
and minor 0 ...

Any hints what has changed and how I can get this kernel to use a
ramdisk as its root device?

Thanks in advance,
best regards,
Heiko


-- 
------------------------------------------------------------------------

*MEINBERG Funkuhren GmbH & Co. KG*
Auf der Landwehr 22
D-31812 Bad Pyrmont, Germany
Tel.: ++49 (0)5281 9309-25
Fax: ++49 (0)5281 9309-30
eMail: heiko.gerstung@meinberg.de <mailto:heiko.gerstung@meinberg.de>
Internet: www.meinberg.de <http://www.meinberg.de/>

------------------------------------------------------------------------

Meinberg radio clocks: 25 years of accurate time worldwide

