Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbULFTBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbULFTBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 14:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbULFTBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 14:01:53 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:55750 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261618AbULFS6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:58:40 -0500
From: "Niel Lambrechts" <antispam@telkomsa.net>
To: "'John Lash'" <jkl@sarvega.com>
Cc: "'Burton Windle'" <bwindle@fint.org>, <linux-kernel@vger.kernel.org>
Subject: RE: kernel panic after changing processor arch
Date: Mon, 6 Dec 2004 20:58:33 +0200
Message-ID: <000101c4dbc5$96844e70$0a00000a@MERCKX>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20041206123705.5fbac5b4@homer.sarvega.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> my first guess would be that the reiserfs module on your 
> initrd needs to be recompiled using the PENTIUMM arch.....
> 
> --john

No.

I did:
make menuconfig - change from i686 to pentiumm - save settings.
make 
make install
mkinitrd -s 1024x768 -k "bzImage.2.6.8-24.5-default" -I "initrd" -m
"reiserfs"
lilo

If I "mount -o loop" the new initrd, modinfo shows the type of
reiserfs.ko to be "PENTIUMM" as I would expect...

I have also tried compiling reiserfs support directly into the kernel
and dropping reiserfs from the -m option, to no avail.

-Niel

