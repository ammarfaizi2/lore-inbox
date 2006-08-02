Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWHBHR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWHBHR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWHBHR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:17:59 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:46266 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751302AbWHBHR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:17:58 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Iomega ATAPI Zip100 problem: 2.4 & 2.6 lilo complains after eject
Date: Wed, 02 Aug 2006 17:17:51 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <oej0d2htdjlp1j9di9lun7ue856b3qkodm@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

This might not be kernel issue as it is lilo that complains:

  "Fatal: open /dev/hdc: Input/output error"

After the zip drive has been used.  Issue is present on both 2.6.18-rc3 
and 2.4.33-rc3.  Box is dual SATA with Zip drive alone on secondary IDE.
configs and dmesgs on: 
	<http://bugsplatter.mine.nu/test/boxen/sempro/>
	<http://bugsplatter.mine.nu/test/boxen/sempro/2.4.xx/>

AMD SktA Sempron with VIA chipset, slackware-10.2

Steps to reproduce:

root@sempro:~# mount /dev/hdc4 /mnt/hd/
root@sempro:~# ls -l /mnt/hd/
total 29238
-rwxr-xr-x  1 root root    22295 2003-12-08 23:42 config-2.4.23*
-rwxr-xr-x  1 root root 29915976 2003-12-08 23:40 vanilla-2.4.23.tar.bz2*
root@sempro:~# eject /mnt/hd/

Zip100 media pops out

root@sempro:~# vim /etc/lilo.conf		# changing reboot default
root@sempro:~# lilo
Warning: COMPACT may conflict with LBA32 on some systems
Fatal: open /dev/hdc: Input/output error

Push Zip100 media back into drive, ZipDrive light flashes...

root@sempro:~# lilo
Warning: COMPACT may conflict with LBA32 on some systems
Added 2.6.18-rc3a
Added 2.6.17.7a *
Added 2.6.16.27a
Added 2.4.33-rc3
Added 2.4.32-hf32.7
Added 2.4.31-hf32.7
Added 2.4.30-hf32.7
Added Slack-2.4.31

root@sempro:~# lilo -V
LILO version 22.5.9

Is this 'normal' for removable media, a kernel problem or a lilo problem?  

Thanks,
Grant
