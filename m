Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUAOIdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 03:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUAOIdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 03:33:23 -0500
Received: from www4.mail.lycos.com ([209.202.220.170]:2548 "HELO lycos.com")
	by vger.kernel.org with SMTP id S266531AbUAOIdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 03:33:13 -0500
To: linux-kernel@vger.kernel.org
Date: Thu, 15 Jan 2004 09:33:05 +0100
From: "Dragan Krnic" <dkrnic@lycos.com>
Message-ID: <PDNDJHLOKGHIMBAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: dkrnic@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Re: extreme performance degradation - ext3/sata
X-Sender-Ip: 145.253.2.28
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've encountered a problem with sata drives and ext3/reiser,
which I documented in the correspondence with Neil Brown
below. He referred me to your forum. Since I'm not subscribed
please cc my return address.

Regards
Dragan

>> I have extreme performance degradation when writing to
>> ext3fs on SATA drives, about 7 times slower than reading
>> from the same volume - 17 MB/s writing, 120 MB/s reading. 
>> 
>> The problem also affects reiserfs in the same way, however
>> xfs appears to be immune to this problem. It reads AND writes
>> to the same volume at about 100 MB/s, which is the same
>> speed at which null-bytes from /dev/zero can be poured
>> into the raw volume.
>> 
>> My setup is: SuSE 8.2 (2.4.20), Siemens Scenic W600 (i865g),
>> P4/3GHz, 2GB PC2100 RAM, a SCSI boot/swap/root disk, 
>> 6 Maxtor 250 GB SATA drives, 2 on on-board connectors,
>> 4 on 2 Promise SATA 150 Tx2+ PCI 32/33 controllers
>> (pdc-ultra.o).
>> 
>> The volumes have been formatted with commands like:
>> 
>>    mke2fs   -J device=/dev/sda2 /dev/md0
>>    mkreiserfs    -j   /dev/sda2 /dev/md0
>>    mkfs.xfs -l logdev=/dev/sda2 /dev/md0
>> 
>> whereby "/dev/md0" may also be "/dev/vg01/lvol1".
>> 
>> The performance degradation, as well as the steady performance
>> of xfs, is totaly independent of the disk clustering mode, 
>> e.g. 5-way RAID5, 6-way RAID5, 3-way RAID0 of 2-way RAID1,
>> 2-way RAID0 (for higher priority on-board controller),
>> 4-way RAID0 (for slightly slower PCI controllers), using
>> either software raid or LVM.
>> 
>> I wish I could give you more info to help you pin-point the
>> performance killer. Please let me know, what more I can do 
>> to help.
