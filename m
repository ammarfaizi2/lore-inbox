Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273955AbSISX6f>; Thu, 19 Sep 2002 19:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273957AbSISX6f>; Thu, 19 Sep 2002 19:58:35 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:59607 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S273955AbSISX6f>; Thu, 19 Sep 2002 19:58:35 -0400
Message-ID: <3D8A65FF.9BA0A2C6@bigpond.com>
Date: Fri, 20 Sep 2002 10:04:15 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Reg Clemens <reg@dwf.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dont understand hdc=ide-scsi behaviour.
References: <200209192108.g8JL8iT6010419@orion.dwf.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reg Clemens wrote:
> 
> I dont understand the behaviour of kernel 2.4.18 (and probably all others) when
> I put the line
>                 hdc=ide-scsi
> on the load line.
> 
> I would EXPECT to get the ide-scsi driver for hdc (my cdwriter) but instead
> get it for BOTH hdc and hdd, the cdwriter and the zip drive.
> 
> After starting this way (with hdc=ide-scsi), I find that
>         /dev/cdrom2 -> /dev/scd0
> and that to access the zip drive I have to use /dev/sda1 (or /dev/sda4)
> 
> I would EXPECT to get to them via /dev/hdd1 or /dev/hdd4.
> 
> Did I miss something or is this a bug????

I presume you are putting the "hdc=ide-scsi" as a kernel param.
I do similarly, EXCEPT the CDwriter is on its own IDE bus.
I suspect that the hdc=ide-scsi thing will apply to both master and slave
on an IDE channel - whether that is intended/mandated I can't say.
If you move the zip to hdb all should be well, or buy an IDE PiC and get
more channels if you have run out.
