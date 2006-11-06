Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753710AbWKFR53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbWKFR53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753718AbWKFR53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:57:29 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:36543 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1753710AbWKFR52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:57:28 -0500
Message-ID: <454F7780.6050506@gmail.com>
Date: Mon, 06 Nov 2006 18:57:20 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jano <jano@90-mo3-3.acn.waw.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
References: <d9a083460611060736h748c12a1s2acc00974f1dd73a@mail.gmail.com>
In-Reply-To: <d9a083460611060736h748c12a1s2acc00974f1dd73a@mail.gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jano wrote:
> Hi everyone,
> 
> Recently I've downloaded and compiled kernel 2.6.18.1. After installing
> modules and kernel and updating Grub I rebooted my box and tried to
> launch new kernel. Everything was launching nicely, but while loading
> GDM the screen went black and I was unable to switch console (using
> ctrl+alt+Fn). I've rebooted using single user mode and logged in as
> root. What I've discovered is the fact that I cannot mount any
> filesystem from /dev/hdb. All filesystems from /dev/hda work as they
> ought to, but when I try to mount something from the second hard disk I
> get:
> 
> # mount -t ext3 /dev/hdb1 /home
> /dev/hdb1 already mounted or /home is busy
> # umount /home
> /home not mounted
> 
> Here you've got my /etc/fstab:
> 
> proc            /proc           proc    defaults        0       0
> /dev/hda3       /               ext3    defaults,errors=remount-ro 0
>   1
> /dev/hda1       /boot           ext3    defaults        0       2
> /dev/hdb1       /home           ext3    defaults        0       2
> /dev/hda5       /usr            ext3    defaults        0       2
> /dev/hda7       none            swap    sw              0       0
> /dev/hdc        /media/cdrom0   udf,iso9660 user,noauto 0       0
> /dev/sda1       /media/usbdisk  vfat    user,auto       0       0
> 
> Currently I am using kernel 2.6.15 from Ubuntu repositories. All
> filesystems work perfectly. Have you got any ideas what might be going
> on?
dmesg >2.6.15
reboot
dmesg >2.6.18
diff -u 2.6.15 2.6.18 >post_this_to_lkml
might help us. Also attach /proc/mounts.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
