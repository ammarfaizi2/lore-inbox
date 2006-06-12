Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752142AbWFLSil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbWFLSil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbWFLSil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:38:41 -0400
Received: from 62-99-178-133.static.adsl-line.inode.at ([62.99.178.133]:20367
	"HELO office-m.at") by vger.kernel.org with SMTP id S1752142AbWFLSik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:38:40 -0400
In-Reply-To: <Pine.LNX.4.61.0606122003190.7959@yvahk01.tjqt.qr>
References: <0CB396BB-A11B-4191-982F-8C0B89F848D6@office-m.at> <Pine.LNX.4.61.0606122003190.7959@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6988083B-3A0E-41F2-A1E4-B4A953B88705@office-m.at>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Markus Biermaier <mbier@office-m.at>
Subject: Re: Can't Mount CF-Card on boot of 2.6.15 Kernel on EPIA - VFS: Cannot open root device
Date: Mon, 12 Jun 2006 20:38:37 +0200
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Am 12.06.2006 um 20:04 schrieb Jan Engelhardt:

>> Hi,
>>
>> I use an EPIA MII6000E motherboard with CF-Card as hard-drive.
>> Since this device can't boot from CF-Card I boot from network via  
>> PXELINUX.
>> Works fine for kernel 2.4.25.
>>
>> Now I want to change to kernel 2.6.15.4.
>>
>> I boot an initrd, execute "linuxrc" and at this point I can mount  
>> the CF-Card
>> as "hde1", inspect the file-system, ...
>>
> Is the proper IDE driver loaded, are you sure the drive is still at  
> hde1
> with 2.6?

Hmm proper IDE driver...
1) I can mount the CF-Card "by hand" and inspect the filesystem. And  
it looks good. I can use the file-system in "near single-user-mode".
2) In my "linuxrc" I do the following to load the modules:
------------------------- [ BEGIN linuxrc ] -------------------------
...
PCIC="ide_cs yenta_socket pcmcia_core pcmcia rsrc_nonstatic"
for Module in $PCIC
do
         modprobe $Module
done
lsmod
...
if [ "$DEBUG" != "" ] ; then
     /bin/sh < /dev/console
fi
...
------------------------- [ END   linuxrc ] -------------------------
Is this indication enough, that I use the  proper IDE driver?

Has the driver (I think "ide_cs"?) which seems to work from the  
initial RAM-disk to be loaded again before the kernel mounts the root- 
fs?
Thanx for any explaination.

>> VFS: Cannot open root device "hde1" or unknown-block(0,0)
>>                                                       ^^^
> Lack of driver. If there was a driver, you would see a non-0,0  
> number at
> least.

Markus

