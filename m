Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316606AbSE0NTO>; Mon, 27 May 2002 09:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316607AbSE0NTN>; Mon, 27 May 2002 09:19:13 -0400
Received: from spook.vger.org ([213.204.128.210]:61621 "HELO
	kenny.worldonline.se") by vger.kernel.org with SMTP
	id <S316606AbSE0NTM>; Mon, 27 May 2002 09:19:12 -0400
Date: Mon, 27 May 2002 15:56:22 +0200 (CEST)
From: me@vger.org
To: Simen Timian Thoresen <simentt@dolphinics.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/hd[ijkl] only using udma (not udma 100)
In-Reply-To: <200205271306.g4RD6Bi11479@scispor.dolphinics.no>
Message-ID: <Pine.LNX.4.21.0205271552081.7794-100000@kenny.worldonline.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2002, Simen Timian Thoresen wrote:

> > Hi,
> > 
> > Ive got a machine running debian test dist and 2.4.18. The machine has two
> > promise ata100 tx2 controller cards. My question is why does the devices
> > hde to hdh use udma100 but devices hdi to hdl only use udma. Note on this
> > is that the devices hdi to hdl did i have to make myself (dont know if
> > there is some other configure possibility). All drives are the same model.
> 
> I'm basically observing the same thing - 5 drives connected alone on their own 
> ata100 channels (1 on a Via southbridge, 4 on HPT370 channels).
> 
> 
> I'm seing speeds 33, 44, 66 and 69 as when examining /proc/ide/hdx/settings. 
> There are 2 differing types of drives, but all are ATA100 capable.
>  
> This is also with 2.4.18, originally slackware 7.1
> 

I booted with:
linux ide0=autotune ide1=autotune ide2=autotune ide3=autotune

and now all drives are running just (U)DMA and speeds on the 3 first
droped to 15m/s.

The settings file you gave here, is there some possibility to configure
settings there? I see things like current_speed and init_speed that would
be nice to try and tweak.


