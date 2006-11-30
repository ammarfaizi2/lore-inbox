Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933046AbWK3JsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046AbWK3JsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933640AbWK3JsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:48:21 -0500
Received: from jdi.jdi-ict.nl ([82.94.239.5]:50148 "EHLO jdi.jdi-ict.nl")
	by vger.kernel.org with ESMTP id S933046AbWK3JsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:48:20 -0500
Date: Thu, 30 Nov 2006 10:48:06 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
X-X-Sender: igmar@jdi.jdi-ict.nl
To: erich <erich@areca.com.tw>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
In-Reply-To: <004901c7141e$15e6cc50$b100a8c0@erich2003>
Message-ID: <Pine.LNX.4.58.0611301036050.27381@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
 <004901c7141e$15e6cc50$b100a8c0@erich2003>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.12 (jdi.jdi-ict.nl [127.0.0.1]); Thu, 30 Nov 2006 10:48:07 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> If you are working on arcmsr 1.20.00.13 for official kernel version.
> This is the last version.

I'm already on that version. I'll see if I can upgrade to 2.6.19 today.

> Could you check your RAID controller event and tell someting to me?
> You can check "MBIOS"=>"Physical Drive Information"=>"View Drive 
> Information"=>"Select The Drive"=>"Timeout Count"......
> It could tell you which disk had bad behavior cause your RAID volume 
> offline.

I need to be in the BIOS right ? I couldn't find anything usefull with the 
cli32 tool.

> About the message dump from arcmsr, it said that your RAID volume had 
> something wrong and kicked out from the system.
> How about your RAID config?

CLI> disk info
Ch   ModelName        Serial#          FirmRev     Capacity  State
===============================================================================
 1   HDT722516DLA380  VDK71BTCDB90KE   V43OA91A     164.7GB  RaidSet 
Member(1)
 2   HDT722516DLA380  VDN71BTCDEPH7G   V43OA91A     164.7GB  RaidSet 
Member(1)
 3   HDT722516DLA380  VDN71BTCDES96G   V43OA91A     164.7GB  RaidSet 
Member(1)
 4   HDT722516DLA380  VDN71BTCDE15KG   V43OA91A     164.7GB  RaidSet 
Member(1)
===============================================================================

CLI> rsf info
Num Name             Disks TotalCap  FreeCap DiskChannels       State
===============================================================================
 1  Raid Set # 00        4  640.0GB    0.0GB 1234               Normal
===============================================================================

CLI> vsf info
 # Name             Raid# Level   Capacity Ch/Id/Lun  State
===============================================================================
 1 ARC-1110-VOL#00    1   Raid5    480.0GB 00/00/00   Normal
===============================================================================

A plain RAID 5 config with 4 disks. 


> Areca had new firmware released (1.42).
> If you are working on "sg" device with scsi passthrough ioctl method to feed 
> data into Areca's RAID volume.
> You need to limit your data under 512 blocks (256K) each transfer.
> The new firmware will enlarge it into 4096 blocks (2M) each transfer.
> The firmware version 1.42 is on releasing procedure but not yet put it on 
> Areca ftp site.

I don't use the sg driver at all. Is the upgrade worth it ? I usually 
don't mess with firmware unless being told to do so.

> If you need it, please tell me again.

Can you send it to me ? Installing it won't hurt I guess :)


Regards,


	Igmar


-- 
Igmar Palsenberg
JDI ICT

Zutphensestraatweg 85
6953 CJ Dieren
Tel: +31 (0)313 - 496741
Fax: +31 (0)313 - 420996
The Netherlands

mailto: i.palsenberg@jdi-ict.nl
