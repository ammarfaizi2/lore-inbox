Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274095AbRIYVWz>; Tue, 25 Sep 2001 17:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273995AbRIYVWf>; Tue, 25 Sep 2001 17:22:35 -0400
Received: from atlrel6.hp.com ([192.151.27.8]:41490 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S273990AbRIYVWY>;
	Tue, 25 Sep 2001 17:22:24 -0400
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D549@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: 2.4.10 still slow compared to 2.4.5pre1
Date: Tue, 25 Sep 2001 17:22:41 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have run 2.4.10 under a heavy nfs load and kswapd now appears to be under
control ( never went above 88.5%cpu and then only for a short time), but the
nfs performance is about 45% of what it had been for the 2.4.5pre1 kernel.
The response time grows steadily throughout the test until the test goes
invalid.

Hardware:
4 processors, 4GB ram
45 fibre channel drives, set up in hardware RAID 0/1
2 direct Gigabit Ethernet connections between SPEC SFS prime client and
system under test
reiserfs
all NFS filesystems exported with sync,no_wdelay to insure O_SYNC writes to
storage
NFS v3 UDP

I can provide top logs if anyone would like to see what is happening at any
particular time.  Also, if you would like to see some results from a
particular test, please let me know what test it would be.

We tried the 00_vmtweaks patch from Andrea and it failed to boot.  There was
an issue starting kswapd and the kernel would oops.

Cary Dickens
Hewlett-Packard

