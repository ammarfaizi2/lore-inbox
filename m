Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbSKCXjI>; Sun, 3 Nov 2002 18:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbSKCXjI>; Sun, 3 Nov 2002 18:39:08 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:37768 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S263342AbSKCXjH>;
	Sun, 3 Nov 2002 18:39:07 -0500
Date: Mon, 4 Nov 2002 00:45:39 +0100
From: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
To: Margit Schubert-While <margit@margit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: U160 on Adaptec 39160
Message-ID: <20021103234539.GC1839@werewolf.able.es>
References: <4.3.2.7.2.20021103124403.00b4c860@mail.dns-host.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <4.3.2.7.2.20021103124403.00b4c860@mail.dns-host.com>; from margit@margit.com on Sun, Nov 03, 2002 at 12:59:44 +0100
X-Mailer: Balsa 2.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.11.03 Margit Schubert-While wrote:
[...]
> 	2 x U160 disks on channel B with special U160 cable and actively
> 	terminated.
> 	DVD + DAT on SE channel A. Nothing on U160 channel A.
[...]
> <4>Attached scsi tape st0 at scsi0, channel 0, id 5, lun 0
> <4>Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
> <4>Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0

Where is DVD ?

[...]
> Channel A Target 0 Negotiation Settings

What you request:
>          User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)

What the hardware detects it can do:
>          Goal: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)

What both agreed to do finally...:
>          Curr: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)

So you hardware thiks it can not do U160. Possibilities:
- Check jumpers on the drive
- Active but SE termination, so no double data rate. Check your terminator
  is LVD.
- SE device at end of chain, so no LVD also (you say your DVD/DAT are on the
  other channel...)

I would vote for SE instead of LVD active terminator ar the cause. At least
'cause I also suffered from it (dam***d hardware dealers...)

Hope this helps.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-rc1-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
