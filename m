Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUBXKFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 05:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbUBXKFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 05:05:34 -0500
Received: from web11805.mail.yahoo.com ([216.136.172.159]:56404 "HELO
	web11805.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262085AbUBXKFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 05:05:31 -0500
Message-ID: <20040224100530.68794.qmail@web11805.mail.yahoo.com>
Date: Tue, 24 Feb 2004 11:05:30 +0100 (CET)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: BOOT_CS
To: linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> H. Peter Anvin writes:
> > Eric W. Biederman wrote:
> > for those folks who want to place their ramdisk as low
> > in memory as possible?
> The problem is that you don't know until it's too late, since it can 
> depend on dynamic factors.  This is part of why your insistence of 
> putting the ramdisk in the "most incorrect" position is simply wrong.

  The other problem is for the people who want to check the validity
 of the RAM disk before starting Linux - for instance by checking
 the CRC32 of the decompressed RAM disk - and stop the boot process
 before it is too late - i.e. in the bootloader when you can select
 another kernel version / initrd to load.
  You cannot place the decompressed initrd at a maximum address before
 knowing its decompressed size - the address to place it is the max
 address (or the end of free RAM) minus ramdisk size if I remember
 correctly. That is working for so long loading the decompressed
 initrd after few Mb after the last kernel byte (so that the kernel
 will move it where it wants - no need to move it twice) that I do
 not remember the details. Did you changed this part?

  Etienne.

Yahoo! Mail - Votre e-mail personnel et gratuit qui vous suit partout !
 Créez votre adresse sur http://mail.yahoo.fr
