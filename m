Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285155AbRLMUTX>; Thu, 13 Dec 2001 15:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285154AbRLMUTN>; Thu, 13 Dec 2001 15:19:13 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:24567 "EHLO
	hawk.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S285159AbRLMUS7>; Thu, 13 Dec 2001 15:18:59 -0500
Message-ID: <3C1880F4.8CE5AC8F@earthlink.net>
Date: Thu, 13 Dec 2001 05:20:36 -0500
From: Jeff <piercejhsd009@earthlink.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: cdrecord reports size vs. capabilities error....
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This I believed may have been asked before, but I am new to this list
and I hope I can get it resolved.
I have a IDE CDR as hdb and a IDE CDRW as hdc, no problem. I know in
order to use cdrecord I must use ide-scsi, no problem as I had this
exact same setup working with cdrecord when this was a 2.2.x system. Ok,
I upgrade the hard drive, hda, and install 2.4.5 kernel from Slackware
8.0. I always install just what I need,and install things as I need
them, usually from source. That's how you learn.
Ok, I need cdrecord working. No problem, I've done this before. Get the
cdrtools-1.10.tar.gz and have at. builds no problem. Build kernel with
scsi emulation, put the append command in lilo.conf, do the modules.conf
thing and link /dev/cdrom to /dev/scd0 and /dev/cdrw to /dev/scd1.
Reboot and I can mount both /dev/cdrom and /dev/cdrw as ro filesystems.
lsmod shows:
Module                  Size  Used by
isofs                  18032   1  (autoclean)
sr_mod                 13024   1  (autoclean)
sg                     21408   0  (autoclean)
ide-scsi                7904   1 
ide-cd                 26432   0 
cdrom                  27520   0  [sr_mod ide-cd]
scsi_mod               81904   3  (autoclean) [sr_mod sg ide-scsi]
3c59x                  24224   1 

Ok, I try cdrecord -scanbus, and get he following warning:
Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
Linux sg driver version: 3.1.17
Using libscg version 'schily-0.5'
scsibus0:
cdrecord: Warning: controller returns wrong size for CD capabilities
page.
        0,0,0     0) 'E-IDE   ' 'CD-ROM 50X      ' '50  ' Removable
CD-ROM
        0,1,0     1) 'HP      ' 'CD-Writer+ 9100 ' '1.0c' Removable
CD-ROM
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
Where did the Warning: come from? Trying to burn from xcdroast causes an
error box stating the same and refuses to write.
I did everything like the cd writer how-to specifies, just like I did
before, I think? Did I miss something?

I google searched and found plenty of postings with the same problem,
but couldn't find any with the answer. One thing I did notice that they
all involved 2.4.x kernel. Is that  the problem?

Jeff
piercejhsd009@earthlink.net
