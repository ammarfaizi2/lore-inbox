Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289627AbSBEQAj>; Tue, 5 Feb 2002 11:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289621AbSBEQA3>; Tue, 5 Feb 2002 11:00:29 -0500
Received: from unicef.org.yu ([194.247.200.148]:30225 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S289627AbSBEQAM>;
	Tue, 5 Feb 2002 11:00:12 -0500
Date: Tue, 5 Feb 2002 16:59:51 +0100 (CET)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: "J.S.Souza" <jss@pacbell.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel compile problem after reboot
In-Reply-To: <PGEMINDOPMDNMJINCKBNMECBCAAA.jss@pacbell.net>
Message-ID: <Pine.LNX.4.33.0202051652220.18074-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Feb 2002, J.S.Souza wrote:

> Date: Tue, 19 Feb 2002 07:47:54 -0800
> From: J.S.Souza <jss@pacbell.net>
> To: linux-kernel@vger.kernel.org
> Subject: Kernel compile problem after reboot
>
> I am using Slack 8 with 2.2.19 and trying to install 2.4.17.  The whole
> compile process goes as planned until I reboot.  After reconfiguring
> lilo.conf and running lilo to update changes, I reboot and when I select the
> new kernel all I get is
>
> Loading Linux........................
>
> Then my computer reboots and this continues to do the same until I select
> the old kernel and it reboots fine.
> Did I do something wrong in lilo?  I merely made a duplicate entry with a
> different image= and label= entry:
>
> image = /boot/vzlinuz-2.4.17
> root = /dev/hda5
> label = Linux_2.4.17
> read-only
>
> I perform the standard:
> make mrproper
> make menuconfig
> make dep && make bzImage && make modules &&
> make modules_install
> cp System.map to /boot
> cp bzImage to /boot
> edit lilo.conf
> run lilo
> reboot
> swear at the computer.
>
do configure the kernel! Do not use defaults!

when you did cp bzImage to /boot
I hope you did cp bzImage /boot/vzlinuz-2.4.17

then try this cp bzImage /dev/fd0
rdev /dev/fd0 /dev/hda5

try to boot from floppy

if that is ok , reconfigure kernel try to boot it.
If it still don't boot perhaps your bios can't reach kernel
for some reason.

if still don't work post description on
what hardware / disk ?

regards,

 Zoran

