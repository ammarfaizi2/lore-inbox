Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWCANRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWCANRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWCANRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:17:46 -0500
Received: from lucidpixels.com ([66.45.37.187]:9603 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932241AbWCANRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:17:45 -0500
Date: Wed, 1 Mar 2006 08:17:42 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <liml@rtr.ca>
cc: "Eric D. Mudama" <edmudama@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <4404F31D.90407@rtr.ca>
Message-ID: <Pine.LNX.4.64.0603010816370.15332@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <4401122A.3010908@rtr.ca>
  <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca>  <4403704E.4090109@rtr.ca>
 <4403A84C.6010804@gmail.com>  <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com>
  <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com>
 <311601c90602280857x3f102af5l31c9a0ac1a896b4e@mail.gmail.com> <4404F31D.90407@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Feb 2006, Mark Lord wrote:

> Eric D. Mudama wrote:
>> those drives should support all FUA opcodes properly, both queued and 
>> unqueued
>
> His first drive (sda) does not support queued commands at all,
> but the newer firmware in his second drive (sdb) does support NCQ.
>
> Both drives support FUA.
>
> cheers
>

Could someone *PLEASE* produce a *unified* patch that is compatible with 
2.6.16-rc5 or 2.6.15.4 so I can reproduce the error?

Mark had two patches, I have had the most PIA time getting them to work, 
patch properly, etc..

With 2.6.16-rc5:

# make bzImage
   CHK     include/linux/version.h
scripts/kconfig/conf -s arch/i386/Kconfig
#
# using defaults found in .config
#
   SPLIT   include/linux/autoconf.h -> include/config/*
   CHK     include/linux/compile.h
   CHK     usr/initramfs_list
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
drivers/built-in.o: In function `ata_to_sense_error': undefined reference 
to `print'
drivers/built-in.o: In function `ata_to_sense_error': undefined reference 
to `print'
make: *** [.tmp_vmlinux1] Error 1
Command exited with non-zero status 2


