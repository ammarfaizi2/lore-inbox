Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314505AbSEMW26>; Mon, 13 May 2002 18:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314512AbSEMW25>; Mon, 13 May 2002 18:28:57 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:28570 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S314505AbSEMW25>; Mon, 13 May 2002 18:28:57 -0400
Date: Mon, 13 May 2002 15:28:56 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
Subject: downgrade ata udma mode at boot time?
Message-ID: <Pine.LNX.4.44.0205131521160.17160-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel: linux-2.4.19-pre7-ac4
ide hardware: promise 20268 ... a pair of ultra100/tx2
disks: 4x maxtor 6L080J4 80GB D740X

so far in my searching i've only found the hdparm -X switch for
downgrading the ata udma mode (to give me temporary respite from 80-pin
cables which are too long). is there any way to do this on the kernel boot
line?

the problem i'm having is that md is kicking in early enough doing a
parity reconstruct, and udma100 is more demanding than my cables can
satisfy.  the case this hardware is in won't accomodate anything less than
24"  cables... long term i'll be replacing the case and cables, i was just
looking for a temporary workaround.

if i try "hdparm -X66 /dev/hd[egik]" while the parity reconstruct is in
process, i get various results.  rarely it succeeds on all disks.
sometimes it succeeds on 3 of 4 disks, but fails on one.  sometimes it
locks up after trying to set /dev/hde.  (it may not actually be completely
locked up, but it's not responding to the console.)

as far as i can tell the system needs to be completely inactive for the
hdparm to succeed, and there's no way for me to guarantee this at boot
time because md will start reconstructing right away.

thanks
-dean

