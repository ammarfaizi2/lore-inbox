Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133021AbRAKTBX>; Thu, 11 Jan 2001 14:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132998AbRAKTBN>; Thu, 11 Jan 2001 14:01:13 -0500
Received: from ns.egsx.com ([206.66.241.18]:36111 "EHLO egsx.com")
	by vger.kernel.org with ESMTP id <S132915AbRAKTAx>;
	Thu, 11 Jan 2001 14:00:53 -0500
Date: Thu, 11 Jan 2001 14:01:58 -0500 (EST)
From: <technews@egsx.com>
To: linux-kernel@vger.kernel.org
Subject: inode leak 2.2.12+ why??
Message-ID: <Pine.LNX.4.10.10101111349240.2361-100000@egsx.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The most puzzling thing is happeneing.  I have compiled a vanillat 2.2.18
kernel with scsi aic7xxx compiled in, 3com network support. (nothing fancy
no sound, no isdn, video, etc...)

I installed this kernel on a redhat 5.2 system, it boots in fine, but then
after some time I get messages saying fork: resource unavailable.  I
checked the inodes and I was chocked to see the number goingg up and up
without stopping.  I changed the value of inode-max to a high number, and
at the same time file-max, but to no avail.  Once it hits that max, it
will not allow me to do anything but shutdown the power to restart.

The server is a production email server, it uses redhat 5.2, sendmail, and
cyrus imap.  The filesystem is ext2 (i tried reiserfs, but I stopped since
I though the leaks are associated with resierfs, but I was wrong)  I tried
compiling the kernel with modules enabled, and also disabled.  Nothing
changes.  The server is single PIII 600E Mhz with 768Mb RAM, and 192G
external raid-5 box connecting via Adaptec UW2 SCSI.

I tried kernel 2.2.12 as well with similar problems, I tried the kernels
with other dual procesesor machines and the same thing happens.  The only
difference is that the inodes do not grow as fast, and when they arrive at
the set inode-max they stop there and they do not go in an endless loop.
I finally had to keep the 2.0.36 kernel on it, it seems very stable no
inode problems there..

Any ideas?? I have read the mailing lists, and people talk about it, and
assosictae it to nfs or squid, and we are not using either one.  ANy help
will be appretiated..

Best regards,
adonis

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
