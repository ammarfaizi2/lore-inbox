Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTIEFCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 01:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbTIEFCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 01:02:00 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:22246 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S262239AbTIEFBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 01:01:33 -0400
Date: Fri, 5 Sep 2003 08:01:31 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-raid@vger.kernel.org
cc: linux-admin@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: 2.4.22 + RAID 1 + SATA + 2 disks => no maximum speed
Message-ID: <Pine.LNX.4.56.0309050757360.18124@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a machine with 2 SATA disks on 2 separate buses.
hdparm -t /dev/hda reports 50MB/s
hdparm -t /dev/hdb reports 50MB/s

I created a raid1 array with hda3 and hdc3, same partition sizes.

If I do hdparm -t /dev/md0 it reports 50MB/s

If I do cat /dev/md0 > /dev/null, vmstat reports 50MB/s
If I start another cat /dev/md0 > /dev/null, in another console, I get
100MB/s from vmstat.

Why I don't get 100MB/s on a single cat command?


Some other test:
cat /dev/hda3 > /dev/null&
cat /dev/hdc3 > /dev/null&
vmstat shows 100MB/s.

Also, seems that writing is very slow (8MB/s).

Any ideas?

Thank you very much!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
