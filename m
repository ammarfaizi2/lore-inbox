Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278358AbRKAM7v>; Thu, 1 Nov 2001 07:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278887AbRKAM7m>; Thu, 1 Nov 2001 07:59:42 -0500
Received: from [200.248.92.2] ([200.248.92.2]:55813 "EHLO
	inter.lojasrenner.com.br") by vger.kernel.org with ESMTP
	id <S278358AbRKAM7c>; Thu, 1 Nov 2001 07:59:32 -0500
Message-Id: <200111011354.LAA26122@inter.lojasrenner.com.br>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Andre Margis <andre@sam.com.br>
Organization: SAM Informatica Ltda
To: Andreas Hartmann <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [VM Kernel 2.4.13] Congratulation - first time, backup has been working without break
Date: Thu, 1 Nov 2001 10:56:18 -0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3BE13FF0.809@athlon.maya.org>
In-Reply-To: <3BE13FF0.809@athlon.maya.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm now testing 2.4.14-pre6, and in at the first time the kswapd is very 
calm, the performance is very better, my DB ENGINE now run with 4 cpu, 2GB 
shared memory buffer pool, on a 4 cpu machine and 4GB RAM using the total 
performance of the machine.

In 2.4.13-ac3 read data from my STORAGE the maximum I/O performance is 
40MBytes/s, but in 2.4.14-pre6 this value grows to 60MBytes/s.

In 2.4.13-ac3 or 2.4.10-ac7 after hours of uptime the machine lost 
performance, he enters in "degraded mode", my process run very slow, I need 
to do a reboot every morning to the performance return to "normal". In 
2.4.14-pre6 this no happens, at this moment, the machine is 1 day uptime, and 
I run big select on database and run very faster, no degradation on 
performance after 1 day of  uptime.

The swap area remains in  0 KB off use. 

In the olds versions when I/O grows, the kswapd grows together using 100% of 
cpu, this not happens in 2.4.14-pre6.

Yestarday I run a total reorg  in the database for tests and runs OK, in 
2.4.13 after a while the VM  locks.

At this time everything is OK


Congratulations for all



André


Em Qui 01 Nov 2001 10:28, Andreas Hartmann escreveu:
> Hello all!
>
> I'm very glad of VM in kernel 2.4.13. It was the first time today, that
> my backup run without any problem and without massive caching on the
> backup-Server (only about 10MB during KDE2-session with konqueror,
> knode, ...) . Working parallel with other applications has acceptable
> performance.
>
> Comparison with 2.4.13-ac4:
> Nearly the same programs running in background, the backup break down
> after about 60s of getting datas via ethernet. At this point, the swap
> has been grown over 56Mb!! Normally (= if the backup runs to the end at
> the second or third try), 300MB swap weren't enough. Working with other
> applications is impossible or painful.
>
>
> I do my backups of the whole harddisks (all in one over 20 GB) with
> rsync (of remote machines too) to another HD on the desktop, which is
> only used for these backups.
>
>
> My system:
> backup-server (also desktop): 512 MB RAM, usually 256 MB cache, Athlon
> 800 with 2 UDMA4-disks (20 and 45GB).
>
> lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [PCI-PCI Bridge]
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
> 10) 00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
> 00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> (rev 30)
> 00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
> [Apollo Super AC97/Audio] (rev 20)
> 00:08.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
> 10/100 Ethernet (rev 02)
> 00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
> (rev 10)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF
>
>
> Unfortunately, there is one great (old) problem with any
> 2.4.x-vanilla-kernel, which isn't fixed until today and which prevents
> me of using the vanilla kernel:
> Usually after some restarts of the X-sserver (4.x.y), my screen (not the
> monitor itself; no sleep-modus is shown) is beginning to go off and on
> again (when the mouse is moved) within seconds. You can't get rid of it
> by restarting X - you have to reboot the machine.
> This problem doesn't occur with ac-kernels.
> I'm using DRI - but without DRI, the problem doesn't disappear :-(. I'm
> using no energy-safing modes - and nothing is configured or compiled
> thereto.
>
>
> Regards,
> Andreas Hartmann
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
