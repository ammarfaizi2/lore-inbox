Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWFIUoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWFIUoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWFIUoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:44:05 -0400
Received: from c-71-234-110-81.hsd1.ct.comcast.net ([71.234.110.81]:56756 "EHLO
	h.klyukin.com") by vger.kernel.org with ESMTP id S965163AbWFIUoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:44:03 -0400
Message-ID: <4489DD91.4060404@klyukin.com>
Date: Fri, 09 Jun 2006 16:44:01 -0400
From: Yaroslav Klyukin <slava@klyukin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ram Gupta <ram.gupta5@gmail.com>
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: booting without initrd
References: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com>
In-Reply-To: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Gupta wrote:
> I am trying to boot with 2.6.16  kernel at my desktop running fedora
> core 4 . It does not boot without initrd generating the message "VFS:
> can not open device "804" or unknown-block(8,4)
> Please append a correct "root=" boot option
> Kernel panic - not syncing : VFS:Unable to mount root fs on
> unknown-block(8,4)
> 
> I have disabled the module support & built in all modules/drivers for
> ide/scsi/sata but it does not boot. I have to disable the module as I
> need a statically built  kernel.

Depending on the type of SATA you use, the hard disk may be called either /dev/sda or /dev/hda
libata emulates SCSI, so it will be called /dev/sda

Find out which partition is /
Eg: /dev/sda2

Then append root=/dev/sda2 to the kernel boot prompt.
If you are using grub, press "e" for "edit".

All that will work given that you have built the proper IDE or SCSI drivers into the kernel.
Also, make sure you have built the proper filesystem support into the kernel too.

> 
> If someone could describe the way to boot without initrd it will be great.
> 
> Thanks in advance for your cooperation.
> Ram Gupta
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

