Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286347AbSAAXIT>; Tue, 1 Jan 2002 18:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286342AbSAAXIC>; Tue, 1 Jan 2002 18:08:02 -0500
Received: from myfilelocker.comcast.net ([24.153.64.6]:58425 "EHLO mtaout45-01")
	by vger.kernel.org with ESMTP id <S286325AbSAAXHn>;
	Tue, 1 Jan 2002 18:07:43 -0500
Date: Tue, 01 Jan 2002 18:07:37 -0500
From: Brian <hiryuu@envisiongames.net>
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <Pine.LNX.4.33.0201012330380.8078-100000@dark.pcgames.pl>
To: Krzysztof Oledzki <ole@ans.pl>, linux-kernel@vger.kernel.org
Message-id: <0GPA00BK988OBK@mtaout45-01.icomcast.net>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0201012330380.8078-100000@dark.pcgames.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an inherent quirk (SCSI folks would say brain damage) in IDE.

Only one drive on an IDE chain may be accessed at once and only one 
request may go to that drive at a time.  Therefore, the maximum you could 
hope for in that test is half speed on each.  Throw in the overhead of 
continuously hopping between them and 12MB is no surprise.

That is why even cheapo Compaqs and Gateways have the hard drive and 
CD-ROM on separate chains.  It's also why IDE RAID cards have a separate 
connector for each drive.

	-- Brian

On Tuesday 01 January 2002 05:34 pm, Krzysztof Oledzki wrote:
> Hello,
>
> There is something wrong with ide data throughput with at last both via
> kt133 and promise pcd20265 controllers.
>
> I have Asus A7V-133 Mobo with VIA KT133A chipset and onboard Promise
> pcd20265 ide controller. My CPU is Athlon 1400 MHz and I have 512 MB of
> PC133 SDRAM. I noticed that connecting two ata100 hdds into the same
> channel makes everything much slower. So I made some test:
