Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270073AbRHGFUT>; Tue, 7 Aug 2001 01:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270074AbRHGFUK>; Tue, 7 Aug 2001 01:20:10 -0400
Received: from web10406.mail.yahoo.com ([216.136.130.98]:12 "HELO
	web10406.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270073AbRHGFUB>; Tue, 7 Aug 2001 01:20:01 -0400
Message-ID: <20010807052011.41452.qmail@web10406.mail.yahoo.com>
Date: Tue, 7 Aug 2001 15:20:11 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: 2.4.7-ac7 kernel, system freezed when copying files onto loop device
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got my system frozen when copying my root partition
to a loop device

dd if=/dev/zero of=root bs=1k count=100k
mke2fs -m 0 root

mount -o loop root /mnt/disk

tar -xf root.tgz -z
(root.tgz is small compressed backup root partition)
cd root
cp -a * /mnt/disk

(the source partition is ext3, target ext2)

it runs for a while and system hang.No message, no
oopses etc..

It did not happen with 2.4.6 with ext3 version 0.9.5
patch.

what is the cause? 

Regards




=====
S.KIEU

_____________________________________________________________________________
http://messenger.yahoo.com.au - Yahoo! Messenger
- Voice chat, mail alerts, stock quotes and favourite news and lots more!
