Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTDXSSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTDXSSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:18:14 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:44812 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263785AbTDXSSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:18:10 -0400
Message-ID: <3EA82D46.6030604@inet6.fr>
Date: Thu, 24 Apr 2003 20:30:30 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Zwickel <martin.zwickel@technotrend.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] hdparm -d1 on boot gives strange errors
References: <20030424101212.4687780c.martin.zwickel@technotrend.de>
In-Reply-To: <20030424101212.4687780c.martin.zwickel@technotrend.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Zwickel wrote:

>Hi there!
>
>I'm running Gentoo, and on boot, a script enables DMA on all IDE-Devices.
>For my 1st disk on hdparm -d1 it waits 15secs and kernel gives strange errors.
>But for my 2nd disk it works ok.
>
>Any clues?
>

See below.

>Is it the damn SiS chipset?
>
>  
>

Maybe but drive/chipset combination is more likely. The one being out of 
spec is unknown to me.


Note :

What I don't understand is why you need the hdparm -d1 : from your boot 
log, the kernel already set DMA for you.

> hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)

> hdb: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63, UDMA(100)


These come after (probably when hdparm -d1 is called)

hda: dma_timer_expiry: dma status == 0x61
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting


My clue :

> WDC WD800BB-00CAA1

Hum, I have a WDC WD800BB-32CCB0 here and it is the only one that wouldn't work correctly with my SiS735-based K7S5A (sometimes values returned by the drive including its id string had one bit forced to 1 or 0, had to reboot to fix the issue).

Try a different drive...

LB.

