Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUANOoy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266313AbUANOoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:44:54 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:8726 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261799AbUANOot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:44:49 -0500
Date: Wed, 14 Jan 2004 14:44:48 +0000
From: Ian Leonard <ian@smallworld.cx>
To: linux-kernel@vger.kernel.org
Subject: Highpoint hpt370 raid and spanning of disks
Message-ID: <20040114144448.GA3426@dino>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have tried to get the htpraid.o module working with spanned raid  
disks with a hpt370 chip (it is a slightly older version). I did this:

1. Setup the raid in the hpt bios
2. loaded the hptraid.o module (kernel: 2.4.24)
3. fdisk /dev/ataraid/d0 and create /dev/ataraid/d0p1
I note that fdisk shows one partition of 80GB (which is correct because  
I 		have 2x40GB disks).
4. mke2fs -j /dev/ataraid/d0p1
5. mount the partition and df shows 80GB.
6. run a test program that fills up the disk with many 1GB files. At  
about the 32nd file I see errors from ext3 and also i/0 errors ide  
controller. The error messages list the hdg device and indicate that  
they can't find sectors in the second disk.

After a reboot, the raid bios marks the 2nd disk with 'broken span'.

I then tried a Promise FastTrak2000 card with very similar results. It  
looks like once data is written to the second disk, something goes  
wrong. Unlike the Highpoint (which produces large numbers of errors)  
the Promise produces a few here and there.

I see from a previous posting that spanning is supported, so I maybe  
missing something. Any help appreciated.


(BTW, this is cross-posted from linux-ide, which doesn't seem to be  
working for me).

--
Ian Leonard

Please ignore spelling and punctuation - I did.
