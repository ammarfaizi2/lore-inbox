Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291106AbSBGEso>; Wed, 6 Feb 2002 23:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291117AbSBGEse>; Wed, 6 Feb 2002 23:48:34 -0500
Received: from ns1.intercarve.net ([216.254.127.221]:24161 "HELO
	ceramicfrog.intercarve.net") by vger.kernel.org with SMTP
	id <S291106AbSBGEs0>; Wed, 6 Feb 2002 23:48:26 -0500
Date: Wed, 6 Feb 2002 23:44:56 -0500 (EST)
From: "Drew P. Vogel" <dvogel@intercarve.net>
To: "J.S.S." <jss@pacbell.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel reboot problem
In-Reply-To: <PGEMINDOPMDNMJINCKBNEEELCAAA.jss@pacbell.net>
Message-ID: <Pine.LNX.4.33.0202062344120.32081-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What does the initrd= line do, and how does initrd-2.4.17-10.img get in
/boot?

--Drew Vogel

On Wed, 20 Feb 2002, J.S.S. wrote:

>What in the world am I doing wrong?
>Whenever I try and compile a kernel, my computer reboots after the message:
>
>Loading Linux.......................
>
>Here's what I do, tell me if it's wrong:
>
>-Download kernel into home dir
>-Unpack
>-Rename and make symbolic link "linux"
>-cd linux
>-make mrproper
>-make menuconfig
>-make dep && make clean && make bzImage && make modules && make
>modules_install
>-cp bzImage to /boot/vmlinuz-2.4.17
>-cp System.map /boot/System.map-2.4.17
>-cd /boot
>-create symbolic link to System.map -> System.map-2.4.17
>-edit lilo.conf:
>
>===========================
>prompt
>timeout=50
>default=linux
>boot=/dev/hda
>map=boot/map
>install=/boot/boot.b
>message=/boot/message
>lba32
>
>image=/boot/vmlinuz-2.4.7-10
>	label=linux
>	initrd=/boot/initrd-2.4.7-10.img
>	read-only
>	root=/dev/hda5
>
>#Add this part for new kernel
>image=/boot/vmlinuz-2.4.17
>	label=Linux-2.4.17
>	read-only
>	root=/dev/hda5
>===========================
>-Run /sbin/lilo
>
>Lilo installs fine without any complaints and EVERYTIME I reboot
>and choose the new kernel the computer reboots after the "Loading
>Linux..................."
>message. It never gets to the "Uncompressing" part of the boot message.
>It's obviously got to
>be something i'm doing wrong.  If redhat and slackware can get their kernels
>to load, then there's no reason
>I shouldn't be able to do my own.  Here's my setup:
>
>Pentium 233
>Intel Chipset
>192 megs RAM
>Maxtor 10g ATA/66
>
>Some help would be much, much appreciated.  I've followed all the examples
>and tried this dozens of times with no success to date.  I've downloaded
>2.4.16 and it did the same thing.  I've tried putting the source and
>unpacking it in the /usr/src directory. I've tried using initrd and
>modifying lilo to reflect it.  The kernel ALWAYS compiles without any error
>codes at the end and none of this seems to matter because in the end it just
>reboots and reboots, etc...
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



