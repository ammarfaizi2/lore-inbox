Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTAMHqc>; Mon, 13 Jan 2003 02:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267153AbTAMHqc>; Mon, 13 Jan 2003 02:46:32 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:59584 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S261368AbTAMHqb>; Mon, 13 Jan 2003 02:46:31 -0500
Date: Sun, 12 Jan 2003 23:55:17 -0800
From: Jack Bowling <jbinpg@shaw.ca>
Subject: Re: initio driver needs updating
In-reply-to: <200210071110.g97BA1J18387@gum09.etpnet.phys.tue.nl>
To: bart@etpmod.phys.tue.nl
Cc: linux-kernel@vger.kernel.org
Reply-to: Jack Bowling <jbinpg@shaw.ca>
Message-id: <0H8N008A67C84E@l-daemon>
MIME-version: 1.0
X-Mailer: The Polarbar Mailer; version=1.24c; build=1746
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
References: <0H3L00G5B1LBJ1@l-daemon>
 <200210071110.g97BA1J18387@gum09.etpnet.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from bart@etpmod.phys.tue.nl on Mon, 07 Oct 2002 13:09:58 +0200 (CEST)


> On  6 Oct, Jack Bowling wrote:
> > Hi, folks. I would love to bang on the latest 2.5.x revs but unfortunately I
> > need an updated initio driver. My attempts at a compile all bomb with the
> > current initio code. Since the freeze is coming up, could somebody please find
> > whomever is responsible for this driver and ask them to write it to the new
> > specs? I would do it myself but I can't code!!
> > 
> 
> Yeah, found the same problem. I am not the maintainer, but more than
> willing to take a shot at it. It has been a while since I rooted around
> in the kernel source, and, more importantly, I would like to use my
> CD-burner with 2.5 :-).

Just an update. Here is the output from an attempted compile of 2.5.56 on the same box. Same hardware as before.

===========begin make output==========

gcc -Wp,-MD,drivers/scsi/.ini9100u.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-p
rototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-
stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default -fomit-frame-po
inter -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ini9100u -DKBUILD_MODN
AME=initio   -c -o drivers/scsi/ini9100u.o drivers/scsi/ini9100u.c
drivers/scsi/ini9100u.c:111:2: #error Please convert me to Documentation/DMA-map
ping.txt
drivers/scsi/ini9100u.c:144: unknown field `next' specified in initializer
drivers/scsi/ini9100u.c:144: warning: initialization from incompatible pointer t
ype
drivers/scsi/ini9100u.c:144: warning: initialization from incompatible pointer t
ype
drivers/scsi/ini9100u.c: In function `i91uBuildSCB':
drivers/scsi/ini9100u.c:492: structure has no member named `address'
drivers/scsi/ini9100u.c:501: structure has no member named `address'
drivers/scsi/hosts.h: At top level:
drivers/scsi/scsi.h:505: warning: `scsi_proc_host_add' declared `static' but nev
er defined
drivers/scsi/scsi.h:506: warning: `scsi_proc_host_rm' declared `static' but neve
r defined
make[2]: *** [drivers/scsi/ini9100u.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

========end make output========

Unsure if it is bombing due to the usual ini9100u problems or changes to the base scsi code.

jb

-- 
Jack Bowling
mailto: jbinpg@shaw.ca
