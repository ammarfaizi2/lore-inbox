Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSH0Uvc>; Tue, 27 Aug 2002 16:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSH0Uvc>; Tue, 27 Aug 2002 16:51:32 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:33171 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317191AbSH0Uv0> convert rfc822-to-8bit; Tue, 27 Aug 2002 16:51:26 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: VM changes added to performance patches for 2.4.19
Date: Tue, 27 Aug 2002 22:53:56 +0200
X-Mailer: KMail [version 1.4]
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208272224.36373.m.c.p@gmx.net>
Cc: Bill Davidsen <davidsen@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

> ...
> against my current production kernel, 2.4.19-ac4. Machine in Athlon
> 1400MHz, 1GB RAM, 20+30GB WD disks.
> ...
> Then I did my nightly backup of a scanned documentation project, making a
> CD image from the scans, currently ~570MB. I was on ck3-aa, and I said
> "self, that seemed pretty fast!" So I rebooted cold and tried the mkisofs
> with both kernels, twice each.

>                         2.4.19-ac4              2.4.19-ck3-aa
> mkisofs 570MB           2:05                    1:14


with WOLK v3.6 and only ONE harddisk drive:

root@codeman:[/] # du -skh /home
605M    /home
root@codeman:[/] # find /home|wc -l
   7384
root@codeman:[/] # time mkisofs -o /delme.iso -allow-multidot -iso-level 3 -J 
-max-iso9660-filenames -U -R /home
...

real    1m12.872s
user    0m1.840s
sys     0m10.800s


with one big file:

root@codeman:[/] # du -skh /home/onebigfile.delme
620M    /home
root@codeman:[/] # time mkisofs -o /delme.iso -allow-multidot -iso-level 3 -J 
-max-iso9660-filenames -U -R /home/onebigfile.delme
...

real    0m35.676s
user    0m1.180s
sys     0m10.740s

:-)

Anyway, I also tested the patchset from Con, both, with -aa VM and -rmap VM 
and I must say, -rmap is much slower than -aa VM.


Testmashine: Celeron 800MHz
             256MB RAM
             1x Seagate 30GB running in UDMA4 (ATA66) mode
             Filesystem: ext3, data=ordered

I think with your mashine this could be a bit faster also ;)

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


