Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUBVXaK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 18:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbUBVXaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 18:30:10 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:43933 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S261214AbUBVXaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 18:30:05 -0500
X-qfilter-stat: ok
X-Analyze: Velop Mail Shield v0.0.4
Date: Sun, 22 Feb 2004 20:30:00 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Remounting device 03:05 ... nothing to do
Message-ID: <Pine.LNX.4.58.0402222024110.15931@pervalidus.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feb 22 20:07:21 pervalidus kernel: SysRq : Emergency Sync
Feb 22 20:07:21 pervalidus kernel: Syncing device 03:06 ... OK
Feb 22 20:07:21 pervalidus kernel: Syncing device 03:08 ... OK
Feb 22 20:07:21 pervalidus kernel: Syncing device 03:09 ... OK
Feb 22 20:07:21 pervalidus kernel: Syncing device 03:05 ... OK
Feb 22 20:07:21 pervalidus kernel: Syncing device 03:0a ... OK
Feb 22 20:07:21 pervalidus kernel: Done.

SysRq : Emergency Remount R/O
Remounting device 03:06 ... OK
Remounting device 03:08 ... OK
Remounting device 03:09 ... OK
Remounting device 03:05 ... nothing to do
Remounting device 03:0a ... R/O
Done.

03:06, 03:08, and 03:09 are ext3.
03:05 is FAT32.
I don't know what 03:0a is (root device ?).

>From the documentation:

'u'     - Will attempt to remount all mounted filesystems read-only.

But why didn't it do it for the FAT32 partition ?

# mount -o remount,ro /mnt/vfat
...
/dev/hda5 on /mnt/vfat type vfat (ro)

So, it works fine manually.

This is on 2.4.25.

-- 
http://www.pervalidus.net/contact.html
