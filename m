Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267595AbSLFUuj>; Fri, 6 Dec 2002 15:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267618AbSLFUuj>; Fri, 6 Dec 2002 15:50:39 -0500
Received: from [81.2.122.30] ([81.2.122.30]:10756 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267595AbSLFUui>;
	Fri, 6 Dec 2002 15:50:38 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212062109.gB6L9GWe000553@darkstar.example.net>
Subject: Re: [2.5.50] IDE error messages appearing after upgrade
To: inkognito.anonym@uni.de
Date: Fri, 6 Dec 2002 21:09:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <10525789281.20021206212219@uni.de> from "Tobias Rittweiler" at Dec 06, 2002 09:22:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Upgrading from 2.4.19 to 2.5.50 results in getting IDE error
> log-messages on startup:
> 
> Dec  6 21:00:23 brood kernel: hda: task_no_data_intr: status=0x51 {
> DriveReady SeekComplete Error }
> Dec  6 21:00:23 brood kernel: hda: task_no_data_intr: error=0x04 {
> DriveStatusError }
> Dec  6 21:00:23 brood kernel: hda: 4128768 sectors (2114 MB)
> w/256KiB Cache, CHS=1024/64/63
> Dec  6 21:00:23 brood kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2
> Dec  6 21:00:23 brood kernel: hdb: task_no_data_intr: status=0x51 {
> DriveReady SeekComplete Error }
> Dec  6 21:00:23 brood kernel: hdb: task_no_data_intr: error=0x04 {
> DriveStatusError }

Ignore these 'errors', they are really warnings - your drive doesn't
recognise some commands being sent to it.

2.4.20 will also show these messages.

> Dec  6 21:00:24 brood kernel: end_request: I/O error, dev hdc, sector 0
> Dec  6 21:00:24 brood kernel: hdc: ATAPI 40X DVD-ROM drive, 512kB Cache
> Dec  6 21:00:24 brood kernel: Uniform CD-ROM driver Revision: 3.12
> Dec  6 21:00:24 brood kernel: end_request: I/O error, dev hdc, sector 0
> Dec  6 21:00:24 brood kernel: end_request: I/O error, dev hdd, sector 0
> Dec  6 21:00:24 brood kernel: end_request: I/O error, dev hdd, sector 0

Not sure about these, though.  I suspect that commands that only
relate to disk devices are being sent to your CD-ROM drives, but
somebody else will probably confirm/deny that.

John.
