Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUHOSBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUHOSBb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 14:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUHOSBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 14:01:31 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:31428 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266836AbUHOSB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 14:01:27 -0400
Message-ID: <411FA4E7.2010405@t-online.de>
Date: Sun, 15 Aug 2004 20:01:11 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040811 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: amd64: Problems with vfat fs?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: b7plFTZeQegkQ6B8LXnU152CVg-Lh10ZV8XPnQLHHDG-4Rf16-WogU
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Is it possible that there is a problem with vfat on amd64?
This is the effect I see:

I want to flash the BIOS of my PC, so I have to write a bootable
DOS image on an USB stick and add the flash program and the new
BIOS file:

	cat DOS.img >/dev/sdd
	mount -t vfat /dev/sdd /mnt
	cp AWDFLASH.EXE FN85S235.BIN /mnt
	umount /mnt

The USB stick boots, but if I run AWDFLASH, then nothing
happens. It justs sits there and doesn't do anything.

But if I try this instead

	cp DOS.img FLASH.img
	mount -t vfat -o loop FLASH.img /mnt
	cp AWDFLASH.EXE FN85S235.BIN /mnt
	umount /mnt
	cat FLASH.img >/dev/sdd

then AWDFLASH works as expected.


Kernel is 2.6.8, but I had problems with 2.6.7, too.


???

Harri

