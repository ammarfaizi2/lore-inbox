Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbTBKVud>; Tue, 11 Feb 2003 16:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbTBKVud>; Tue, 11 Feb 2003 16:50:33 -0500
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:39686 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S266292AbTBKVua>;
	Tue, 11 Feb 2003 16:50:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
Message-Id: <200302112258.21146@gandalf>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.60
Date: Tue, 11 Feb 2003 23:00:14 +0100
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 February 2003 20:08, Linus Torvalds wrote:
> Ok, this contains a lot of patches all over the map, since there were two 
> weeks of merging to be done (and the merging took almost a week).
> 
> Networking, USB, SCSI, ALSA, ACPI, and various architecture updates (UML,
> Sparc, ia64, ppc64 and ARM).

this broke the compile of aha152x:

  gcc -Wp,-MD,drivers/scsi/.aha152x.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i586 -Iinclude/asm-i386/mach-default 
-fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE  -DAHA152X_STAT 
-DAUTOCONF -DKBUILD_BASENAME=aha152x -DKBUILD_MODNAME=aha152x -c -o 
drivers/scsi/aha152x.o drivers/scsi/aha152x.c
drivers/scsi/aha152x.c: In function `remove_lun_SC':
drivers/scsi/aha152x.c:774: structure has no member named `target'
drivers/scsi/aha152x.c:774: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `aha152x_porttest':
drivers/scsi/aha152x.c:874: warning: `__check_region' is deprecated (declared 
at include/linux/ioport.h:111)
drivers/scsi/aha152x.c: In function `tc1550_porttest':
drivers/scsi/aha152x.c:892: warning: `__check_region' is deprecated (declared 
at include/linux/ioport.h:111)
drivers/scsi/aha152x.c: In function `aha152x_internal_queue':
drivers/scsi/aha152x.c:1479: structure has no member named `host'
drivers/scsi/aha152x.c:1499: structure has no member named `host'
drivers/scsi/aha152x.c:1499: structure has no member named `target'
drivers/scsi/aha152x.c:1499: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `aha152x_abort':
drivers/scsi/aha152x.c:1592: structure has no member named `host'
drivers/scsi/aha152x.c:1597: structure has no member named `host'
drivers/scsi/aha152x.c:1597: structure has no member named `target'
drivers/scsi/aha152x.c:1597: structure has no member named `lun'
drivers/scsi/aha152x.c:1635: structure has no member named `host'
drivers/scsi/aha152x.c:1635: structure has no member named `target'
drivers/scsi/aha152x.c:1635: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `timer_expired':
drivers/scsi/aha152x.c:1644: structure has no member named `host'
drivers/scsi/aha152x.c: In function `aha152x_device_reset':
drivers/scsi/aha152x.c:1666: structure has no member named `host'
drivers/scsi/aha152x.c:1679: structure has no member named `host'
drivers/scsi/aha152x.c:1679: structure has no member named `target'
drivers/scsi/aha152x.c:1679: structure has no member named `lun'
drivers/scsi/aha152x.c:1684: structure has no member named `host'
drivers/scsi/aha152x.c:1684: structure has no member named `host'
drivers/scsi/aha152x.c:1685: structure has no member named `target'
drivers/scsi/aha152x.c:1685: structure has no member named `target'
drivers/scsi/aha152x.c:1686: structure has no member named `lun'
drivers/scsi/aha152x.c:1686: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `aha152x_bus_reset':
drivers/scsi/aha152x.c:1741: structure has no member named `host'
drivers/scsi/aha152x.c: In function `aha152x_host_reset':
drivers/scsi/aha152x.c:1825: structure has no member named `host'
drivers/scsi/aha152x.c: In function `done':
drivers/scsi/aha152x.c:1889: structure has no member named `host'
drivers/scsi/aha152x.c:1889: structure has no member named `target'
drivers/scsi/aha152x.c:1889: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `busfree_run':
drivers/scsi/aha152x.c:2055: structure has no member named `host'
drivers/scsi/aha152x.c:2055: structure has no member named `host'
drivers/scsi/aha152x.c:2056: structure has no member named `target'
drivers/scsi/aha152x.c:2056: structure has no member named `target'
drivers/scsi/aha152x.c:2057: structure has no member named `lun'
drivers/scsi/aha152x.c:2057: structure has no member named `lun'
drivers/scsi/aha152x.c:2066: structure has no member named `host'
drivers/scsi/aha152x.c:2066: structure has no member named `target'
drivers/scsi/aha152x.c:2066: structure has no member named `lun'
drivers/scsi/aha152x.c:2116: structure has no member named `target'
drivers/scsi/aha152x.c: In function `seldo_run':
drivers/scsi/aha152x.c:2148: structure has no member named `host'
drivers/scsi/aha152x.c:2148: structure has no member named `target'
drivers/scsi/aha152x.c:2148: structure has no member named `lun'
drivers/scsi/aha152x.c:2155: structure has no member named `lun'
drivers/scsi/aha152x.c:2161: structure has no member named `target'
drivers/scsi/aha152x.c:2169: structure has no member named `target'
drivers/scsi/aha152x.c:2172: structure has no member named `target'
drivers/scsi/aha152x.c: In function `seldi_run':
drivers/scsi/aha152x.c:2227: structure has no member named `host'
drivers/scsi/aha152x.c:2227: structure has no member named `target'
drivers/scsi/aha152x.c:2227: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `msgi_run':
drivers/scsi/aha152x.c:2343: structure has no member named `host'
drivers/scsi/aha152x.c:2343: structure has no member named `target'
drivers/scsi/aha152x.c:2343: structure has no member named `lun'
drivers/scsi/aha152x.c:2356: structure has no member named `target'
drivers/scsi/aha152x.c:2357: structure has no member named `host'
drivers/scsi/aha152x.c:2357: structure has no member named `target'
drivers/scsi/aha152x.c:2357: structure has no member named `lun'
drivers/scsi/aha152x.c:2358: structure has no member named `target'
drivers/scsi/aha152x.c:2360: structure has no member named `host'
drivers/scsi/aha152x.c:2360: structure has no member named `target'
drivers/scsi/aha152x.c:2360: structure has no member named `lun'
drivers/scsi/aha152x.c:2381: structure has no member named `host'
drivers/scsi/aha152x.c:2381: structure has no member named `target'
drivers/scsi/aha152x.c:2381: structure has no member named `lun'
drivers/scsi/aha152x.c:2388: structure has no member named `host'
drivers/scsi/aha152x.c:2388: structure has no member named `target'
drivers/scsi/aha152x.c:2388: structure has no member named `lun'
drivers/scsi/aha152x.c:2398: structure has no member named `host'
drivers/scsi/aha152x.c:2398: structure has no member named `target'
drivers/scsi/aha152x.c:2398: structure has no member named `lun'
drivers/scsi/aha152x.c:2402: structure has no member named `target'
drivers/scsi/aha152x.c:2418: structure has no member named `target'
drivers/scsi/aha152x.c:2421: structure has no member named `host'
drivers/scsi/aha152x.c:2421: structure has no member named `target'
drivers/scsi/aha152x.c:2421: structure has no member named `lun'
drivers/scsi/aha152x.c:2425: structure has no member named `target'
drivers/scsi/aha152x.c:2426: structure has no member named `target'
drivers/scsi/aha152x.c: In function `msgi_end':
drivers/scsi/aha152x.c:2459: structure has no member named `host'
drivers/scsi/aha152x.c:2459: structure has no member named `target'
drivers/scsi/aha152x.c:2459: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `msgo_init':
drivers/scsi/aha152x.c:2474: structure has no member named `target'
drivers/scsi/aha152x.c:2474: structure has no member named `target'
drivers/scsi/aha152x.c:2475: structure has no member named `lun'
drivers/scsi/aha152x.c:2477: structure has no member named `host'
drivers/scsi/aha152x.c:2477: structure has no member named `target'
drivers/scsi/aha152x.c:2477: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `msgo_end':
drivers/scsi/aha152x.c:2533: structure has no member named `host'
drivers/scsi/aha152x.c:2533: structure has no member named `target'
drivers/scsi/aha152x.c:2533: structure has no member named `lun'
drivers/scsi/aha152x.c:2534: structure has no member named `target'
drivers/scsi/aha152x.c:2535: structure has no member named `host'
drivers/scsi/aha152x.c:2535: structure has no member named `target'
drivers/scsi/aha152x.c:2535: structure has no member named `lun'
drivers/scsi/aha152x.c:2536: structure has no member named `target'
drivers/scsi/aha152x.c: In function `cmd_init':
drivers/scsi/aha152x.c:2551: structure has no member named `host'
drivers/scsi/aha152x.c:2551: structure has no member named `target'
drivers/scsi/aha152x.c:2551: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `cmd_end':
drivers/scsi/aha152x.c:2592: structure has no member named `host'
drivers/scsi/aha152x.c:2592: structure has no member named `target'
drivers/scsi/aha152x.c:2592: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `datai_run':
drivers/scsi/aha152x.c:2659: structure has no member named `host'
drivers/scsi/aha152x.c:2659: structure has no member named `target'
drivers/scsi/aha152x.c:2659: structure has no member named `lun'
drivers/scsi/aha152x.c:2672: structure has no member named `host'
drivers/scsi/aha152x.c:2672: structure has no member named `target'
drivers/scsi/aha152x.c:2672: structure has no member named `lun'
drivers/scsi/aha152x.c:2714: structure has no member named `host'
drivers/scsi/aha152x.c:2714: structure has no member named `target'
drivers/scsi/aha152x.c:2714: structure has no member named `lun'
drivers/scsi/aha152x.c:2735: structure has no member named `host'
drivers/scsi/aha152x.c:2735: structure has no member named `target'
drivers/scsi/aha152x.c:2735: structure has no member named `lun'
drivers/scsi/aha152x.c:2742: structure has no member named `host'
drivers/scsi/aha152x.c:2742: structure has no member named `target'
drivers/scsi/aha152x.c:2742: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `datao_run':
drivers/scsi/aha152x.c:2794: structure has no member named `host'
drivers/scsi/aha152x.c:2794: structure has no member named `target'
drivers/scsi/aha152x.c:2794: structure has no member named `lun'
drivers/scsi/aha152x.c:2828: structure has no member named `host'
drivers/scsi/aha152x.c:2828: structure has no member named `target'
drivers/scsi/aha152x.c:2828: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `update_state':
drivers/scsi/aha152x.c:2917: structure has no member named `host'
drivers/scsi/aha152x.c:2917: structure has no member named `target'
drivers/scsi/aha152x.c:2917: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `parerr_run':
drivers/scsi/aha152x.c:2936: structure has no member named `host'
drivers/scsi/aha152x.c:2936: structure has no member named `target'
drivers/scsi/aha152x.c:2936: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `is_complete':
drivers/scsi/aha152x.c:3056: structure has no member named `host'
drivers/scsi/aha152x.c:3056: structure has no member named `target'
drivers/scsi/aha152x.c:3056: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `show_command':
drivers/scsi/aha152x.c:3379: structure has no member named `target'
drivers/scsi/aha152x.c:3379: structure has no member named `lun'
drivers/scsi/aha152x.c: In function `get_command':
drivers/scsi/aha152x.c:3444: structure has no member named `target'
drivers/scsi/aha152x.c:3444: structure has no member named `lun'
make[1]: *** [drivers/scsi/aha152x.o] Error 1
make: *** [drivers/scsi/aha152x.o] Error 2

