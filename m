Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276023AbRI1MPs>; Fri, 28 Sep 2001 08:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276025AbRI1MPj>; Fri, 28 Sep 2001 08:15:39 -0400
Received: from empr3-188.menta.net ([62.57.108.188]:17400 "EHLO www.bosch.es")
	by vger.kernel.org with ESMTP id <S276023AbRI1MPZ> convert rfc822-to-8bit;
	Fri, 28 Sep 2001 08:15:25 -0400
Message-ID: <3BB469E1.9090205@juridicas.com>
Date: Fri, 28 Sep 2001 14:15:29 +0200
From: Jorge =?ISO-8859-1?Q?Ner=EDn?= <jnerin@juridicas.com>
Reply-To: comandante@zaralinux.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: es-es, es, en
MIME-Version: 1.0
To: safemode <safemode@speakeasy.net>
CC: linux-kernel@vger.kernel.org, gadio@netvision.net.il
Subject: Re: ide-scsi driver trouble in ac15
In-Reply-To: <20010928040722Z275827-760+17888@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

safemode wrote:

>I'm not entirely sure if this is ac15's fault or the preempt patch acting up. 
>But this is very ide-scsi centric so i'm leaning towards ac15.  I burned a cd 
>using my ide writer and it worked fine.  Then i went to burn another and the 
>drive went into an infinite reset loop.  like this.
>	SCSI bus is being reset for host 0 channel 0.
>	scsi0 : channel 0 target 0 lun 0 request sense failed, performing reset.
>
>reloading the modules does nothing but report this error. 
>	SCSI subsystem driver Revision: 1.00
>	scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>	scsi0 : channel 0 target 0 lun 0 request sense failed, performing reset.
>	SCSI bus is being reset for host 0 channel 0.
>
>Even though the modules were removed, the drive led is still blinking like it 
>was writing.  If anyone needs some more info i'll try and get it. 
>the cdr did detect and work correctly at boot. 
>
>hardware:
>    Promise ide controller : 
>	PDC20262: chipset revision 1
>	PDC20262: not 100% native mode: will probe irqs later
>	PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
>    CDR: 
>	hde: CREATIVE CD-RW RW8438E, ATAPI CD/DVD-ROM drive
>	SCSI subsystem driver Revision: 1.00
>	scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>  	Vendor: CREATIVE  Model:  CD-RW RW8438E    Rev: FC03
>  	Type:   CD-ROM                             ANSI SCSI revision: 02
>software:
>    Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
>    linux-2.4.9-ac15-preempt-fix
>
It also happened to me with ac10, ide-scsi, CD-RW is a Samsung 8x, and I 
was writing a audio cd, when it finished writing the track 8 of 18 it 
entered the loop, since then I couldn't eject the cd, neither eject 
/dev/hdb, nor cdrecord -eject, nor the eject button, I had to reboot.

My system is a 2x200mmx smp all ide.

-- 
Jorge Nerin
<comandante@zaralinux.com>



