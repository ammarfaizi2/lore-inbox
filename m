Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756360AbWK0Dea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbWK0Dea (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 22:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756367AbWK0Dea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 22:34:30 -0500
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:16362
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1756358AbWK0Dea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 22:34:30 -0500
Message-ID: <00f501c711d4$f04c7530$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Maurice Volaski" <mvolaski@aecom.yu.edu>
Cc: =?UTF-8?B?KOW7o+WuieenkeaKgCnomIfojonltZA=?= <lusa@areca.com.tw>,
       =?UTF-8?B?KOW7o+WuieenkeaKgCnnvoXku7vlgYk=?= 
	<robert.lo@areca.com.tw>,
       =?UTF-8?B?KOW7o+WuieenkeaKgCnnjovlrrbku7I=?= <kevin34@areca.com.tw>,
       <support@areca.com.tw>, <linux-kernel@vger.kernel.org>
References: <a06240400c18e4b03eadf@[129.98.90.227]>
Subject: Re: Pathetic write performance from Areca PCIe cards
Date: Mon, 27 Nov 2006 11:34:23 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.2663
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2757
X-OriginalArrivalTime: 27 Nov 2006 03:24:47.0875 (UTC) FILETIME=[975FAD30:01C711D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maurice Volaski,

Please update Areca Firmware version into 1.42.
Areca's firmware team found some problems on high capacity transfer.
Hope the weird  phenomenon should disappear.

Areca had some experiences from its subsystem producers about vibration.
The vibration issue can lower your transfer rate.
The vibration factor always comes from system's power supply and cooling 
fans.

In Areca Lab. will research if there were any compatibility issue with these 
type disks of you used.

Best Regards
Erich Chen


----- Original Message ----- 
From: "Maurice Volaski" <mvolaski@aecom.yu.edu>
To: <support@areca.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <erich@areca.com.tw>
Sent: Sunday, November 26, 2006 4:35 AM
Subject: Pathetic write performance from Areca PCIe cards


>I have two systems with a serious I/O subsystem based on Areca PCIe cards, 
>but the results I am getting from simple write benchmarks are extremely 
>slow.
>
> The details are two 64-bit Opteron systems, one with an Areca PCIe 1210 
> and the other a PCIe 1220 and both with Seagate SATA II 750 GB drives. The 
> motherboard is a Tyan S2891 (Thunder K8SRE). The 120 system has 1 GB of 
> PC2700 RAM and the 1220 system has 2GB of PC3200 RAM. The Areca BIOS on 
> both cards is version 1.17a and the firmware is 1.41.
> I have tried two different kernels, 2.6.17 from Ubuntu, which had the 
> Areca driver added by Ubuntu and 2.6.18 from Gentoo with the Areca driver 
> added manually from 2.6.19-rc3.
>
> In the initial tests, both computers had a RAID 5/6 configuration, but to 
> confirm the result, I setup a single Seagate as a pass-through drive and 
> had the same results. The drive was set to SATA II with NCQ and the cache 
> was enabled to write-back.
>
> dd if=/dev/zero of=output oflag=sync bs=100M count=1 gives an excellent 
> result, around 188 MB/sec.
> dd if=/dev/zero of=output oflag=sync bs=200M count=1 gives an excellent 
> result, around 167 MB/sec.
> dd if=/dev/zero of=output oflag=sync bs=300M count=1 gives an OK result, 
> around 117 MB/sec.
> dd if=/dev/zero of=output oflag=sync bs=400M count=1 gives a very poor 
> result, around 35 MB/sec.
> These very low numbers around 30 MB/sec persist as I increase the bs 
> number.
>
> As I continue to run the tests, the bs that gives a poor results goes down 
> to about 200 MB. The results are from the system with the 1220 card. The 
> system with 1210 gives slightly lower numbers overall.
>
> I have also confirmed these low numbers using a benchmark called dm from 
> the network RAID package, drbd.
>
> Reading from the drives (based on hdparm -tT testing) gives excellent 
> results.
>
> When I use the drive directly connected to the SATA on the motherboard, 
> all the write tests hover around 56 MB/second regardless of bs value.
>
> Since both systems are affected, my guess is there is bug in the Areca 
> driver or with the cards themselves.
> -- 
>
> Maurice Volaski, mvolaski@aecom.yu.edu
> Computing Support, Rose F. Kennedy Center
> Albert Einstein College of Medicine of Yeshiva University 

