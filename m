Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319505AbSIGSoN>; Sat, 7 Sep 2002 14:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319506AbSIGSoN>; Sat, 7 Sep 2002 14:44:13 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:37385
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319505AbSIGSoM>; Sat, 7 Sep 2002 14:44:12 -0400
Date: Sat, 7 Sep 2002 11:47:51 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bob McElrath <mcelrath+kernel@draal.physics.wisc.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ide-scsi oops
In-Reply-To: <20020907183328.GB5985@draal.physics.wisc.edu>
Message-ID: <Pine.LNX.4.10.10209071143080.16589-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Sep 2002, Bob McElrath wrote:

>                                 Intel PIIX4 Ultra 100 Chipset.
> --------------- Primary Channel ---------------- Secondary Channel -------------
>                  enabled                          enabled
> --------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
> DMA enabled:    yes              no              yes               no 
> UDMA enabled:   yes              no              no                no 
> UDMA enabled:   5                X               X                 X
                                                 ^^^^^

> (0)<mcelrath@navi:/home/mcelrath> sudo cat /proc/ide/ide1/hdc/identify 
> 85c0 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 3432 3434 3430 3734 3636 2020
> 2020 2020 2020 2020 0000 1000 0000 3130
> 3136 2020 2020 544f 5348 4942 4120 4456
> 442d 524f 4d20 5344 2d52 3231 3032 2020
> 2020 2020 2020 2020 2020 2020 2020 0000
> 0000 0f00 0000 0400 0200 0006 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0407
                                     ^^^^		== 34 MW2

> 0003 0078 0078 0078 0078 0000 0000 0000
> 0000 0004 0009 0000 0000 0000 0000 0000
> 003c 0013 0000 0000 0000 0000 0000 0000
> 0007 0000 0000 0000 0000 0000 0000 0000
  ^^^^						capable == 66 U33

> (0)<mcelrath@navi:/home/mcelrath> sudo cat /proc/ide/ide1/hdc/settings 
> name                    value           min             max             mode
> ----                    -----           ---             ---             ----

> current_speed           34              0               70              rw
> ide-scsi                0               0               1               rw
> init_speed              66              0               70              rw


Would you pass hdc=scsi for the next reboot?

Andre Hedrick
LAD Storage Consulting Group

