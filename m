Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbRFVIU4>; Fri, 22 Jun 2001 04:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265370AbRFVIUq>; Fri, 22 Jun 2001 04:20:46 -0400
Received: from gg.gbf.de ([193.175.244.3]:49634 "EHLO rzgate.gbf.de")
	by vger.kernel.org with ESMTP id <S265369AbRFVIUe>;
	Fri, 22 Jun 2001 04:20:34 -0400
Message-ID: <3B32FF8E.5030103@gbf.de>
Date: Fri, 22 Jun 2001 10:19:26 +0200
From: Joachim Reichelt <Reichelt@gbf.de>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us, de
MIME-Version: 1.0
To: reiserfs-list@namesys.com
CC: linux-kernel@vger.kernel.org
Subject: Deadlock
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.7.0.1)
X-AntiVirus: OK (checked by AntiVir Version 6.7.0.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo all,

I've setup a mailserver with
dual PIII/1000, AMI-Megaraid and NCR-scsi

On the Raid i have (from df)
/dev/sda3              4200856   3517456    683400  84% /
/dev/sda1                54410     13254     38347  26% /boot
/dev/sda5              8393656     36048   8357608   1% /tmp
/dev/sda6             20803488   1093756  19709732   6% /var

and a vg of two AMI-luns:

/dev/home/homes      248898128   7228820 241669308   3% /home

mount
/dev/sda3 on / type reiserfs (rw,notail)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/sda1 on /boot type ext2 (rw)
/dev/sda5 on /tmp type reiserfs (rw,notail)
/dev/sda6 on /var type reiserfs (rw,noatime,nodiratime,notail)
/dev/home/homes on /home type reiserfs (rw,noatime,nodiratime,notail)
automount(pid1523) on /misc type autofs 
(rw,fd=5,pgrp=1523,minproto=2,maxproto=4)
automount(pid1540) on /net type autofs 
(rw,fd=5,pgrp=1540,minproto=2,maxproto=4)

on the ncr is a DLT Tape

kernel is vanilla 2.4.4

once a month i get a deadlock of the whole system during backup.
What can i do
    to get the bug fixed
or
    to get not affected by it any longer

-- 
Mit freundlichen Gruessen                         Best Regards
 
         Joachim Reichelt
 
SF  - Strukturforschung                                       RZ  - Rechenzentrum
              GBF - Gesellschaft fuer Biotechnologische Forschung
                    German Research Centre for Biotechnology

WWW: http://www.gbf.de        _/_/_/   _/_/_/   _/_/_/_/
EMAIL: REICHELT@gbf.de      _/    _/  _/   _/  _/
                           _/        _/   _/  _/
Mascheroder Weg 1         _/  _/    _/_/_/   _/_/_/
D-38124 Braunschweig      _/    _/  _/   _/  _/ 
Tel: +(49) 531 6181 352  _/    _/  _/   _/  _/ 
FAX: +(49) 531 2612 388   _/_/_/   _/_/_/   _/ 

NEU:
NEW:
SF: http://struktur.gbf.de/
    http://struktur.gbf.de/msf/mm.html
RZ: http://wtd.gbf.de/rz/rz.html

-- Disclaimer --
Standard > Keyword : Opinions, my own, nobody else's, whatsoever ...

Man muss sich notfalls jemand mieten,
hat man an Geist selbst nichts zu bieten!     (Heinz Erhardt)


