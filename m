Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbTLCQI0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 11:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265049AbTLCQIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 11:08:25 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:41695 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265048AbTLCQIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 11:08:23 -0500
Date: Wed, 3 Dec 2003 17:08:08 +0100
To: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Problem with USB disk
Message-ID: <20031203160808.GA1974@feivel.fam-meskes.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: michael@fam-meskes.de (Michael Meskes)
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:da5cff6069dd6897c77170232368d0ba
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please take my apologies if this is old news, I didn't find much about
it on the net though.]

Hi,

I used to run a crypted 120GB disk for some data storage without any problem
so far. Now I got myself a notebook and tried connecting this disk via a
USB adapter. This works okay for some time, but at some point errors
out:

Dec  3 10:25:50 feivel kernel: SCSI device sda: 241254720 512-byte hdwr sectors (123522 MB)
Dec  3 10:25:50 feivel kernel: sda: assuming drive cache: write through
Dec  3 10:25:50 feivel kernel:  /dev/scsi/host2/bus0/target0/lun0: p1
Dec  3 10:25:50 feivel kernel: Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
Dec  3 10:25:50 feivel kernel: WARNING: USB Mass Storage data integrity not assured
Dec  3 10:25:50 feivel kernel: USB Mass Storage device found at 3
Dec  3 10:28:15 feivel kernel: scsi: Device offlined - not ready after error recovery: host 2 channel 0 id 0 lun 0
Dec  3 10:28:15 feivel kernel: SCSI error : <2 0 0 0> return code = 0x6070000
Dec  3 10:28:15 feivel kernel: end_request: I/O error, dev sda, sector 191
Dec  3 10:28:15 feivel kernel: Buffer I/O error on device loop1, logical block 64
Dec  3 10:28:15 feivel kernel: Buffer I/O error on device loop1, logical block 65
...

Actually this already happens when I just try to e2fsck the ext3
filesystem on this disk. It always fails.

I tried enabling verbose messages in USB but this doens't change much it
seems:

...
Dec  3 13:36:33 feivel kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Dec  3 13:36:33 feivel kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001005 POWER sig=se0  PE CONNECT
Dec  3 13:36:49 feivel kernel: scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun 0
Dec  3 13:36:49 feivel kernel: SCSI error : <1 0 0 0> return code = 0x6070000
Dec  3 13:36:49 feivel kernel: end_request: I/O error, dev sda, sector 191
Dec  3 13:36:49 feivel kernel: Buffer I/O error on device loop1, logical block 64
...

All this is kernel vesion 2.6.0-test11. I also tried test9 with the same
results and 2.4.21, but that didn't work either.

I'm not sure where to look now. Any ideas?

Michael

P.S.: Please CC me on replies.
-- 
Michael Meskes
Email: Michael at Fam-Meskes dot De
ICQ: 179140304, AIM/Yahoo: michaelmeskes, Jabber: meskes@jabber.org
Go SF 49ers! Go Rhein Fire! Use Debian GNU/Linux! Use PostgreSQL!
