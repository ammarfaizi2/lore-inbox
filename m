Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130217AbRCCBpQ>; Fri, 2 Mar 2001 20:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130223AbRCCBpG>; Fri, 2 Mar 2001 20:45:06 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:13521 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130217AbRCCBoy>; Fri, 2 Mar 2001 20:44:54 -0500
Message-ID: <3AA04B88.9B4E5AF8@coplanar.net>
Date: Fri, 02 Mar 2001 20:40:24 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy <prrthd25@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: VFS: Cannot open root device
In-Reply-To: <20010303011000.1832.qmail@web4203.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy wrote:

This is going to get confusing!

> Hello all,
>  HELP, I have a new server that I am trying to put
> Redhat 7.0 on. It is a Compaq Proliant ML530 Dual PIII
> 1Ghz with a Gig of RAM. It has a Compaq smart array
> 5300 in it also. It boots just fine with the default
> Redhat 7 kernel 2.2.16smp but when I compiled my own
> 2.4.2 kernel I get the following message.
>
> request_module[scsi_host_adapter]: Root FS not mounted
> request_module[scsi_host_adapter]: Root FS not mounted

2 possibilities: you misconfigured kernel or didn't
make  an initial ramdisk to load scsi modules.

to make a good configuration, you may wish to use the config
files that redhat used to build the kernel you say works,
and then just tweak a few things like processor type.
they're installed (i think) in /usr/src/linux/configs
if you install kernel-source package.

try command 'man mkinitrd' under redhat
for hints about initial ramdisk.

>
>
> Then some standard lines Then:
>
> NET 4: Unix domain sockets 1.0/SMP for Linux NET 4.0
> request_module[block-major-104]: Root FS not mounted
> VFS: Cannot open root device "6802" or 68:02
> Please append a correct "root=" boot option
> Kernel Panic: VFS: Unable to mount root FS on 68:02
>
>  When I boot 2.2.16 the only modules that are loaded
> are cciss, NCR53C8XX, eepro100 and tlan. I have triple
> checked and I have built cciss and NCR53C8XX into the
> kernel, I even tried them as modules. It almost looks
> like it just isn't loading the NCR53C8XX and then it
> cant mount the File system.
>  If you need any more info please let me know.
>
> Please CC anything to me directly since I am not on
> the mailing list.
>
> Thanks,
>    Jeremy

