Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264492AbRFYNPg>; Mon, 25 Jun 2001 09:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264503AbRFYNP1>; Mon, 25 Jun 2001 09:15:27 -0400
Received: from smtp-rt-10.wanadoo.fr ([193.252.19.59]:59850 "EHLO
	camelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264492AbRFYNPJ>; Mon, 25 Jun 2001 09:15:09 -0400
Message-ID: <3B373949.5A53BF83@wanadoo.fr>
Date: Mon, 25 Jun 2001 15:14:49 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20pre5 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi detecting CDR as "CD-ROM" in 2.2.19
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Fabian Arias <dewback@vtr.net> wrote :
>Try cdrecord --scanbus and folow the directions on CD-Writing HOWTO.

The behaviour (even if I can run the burner with both), is different
with
2.2.20pre (or 2.2.19) and 2.4.5-ac.

This is what tells cdrecord -scanbus in 2.4.5-ac17 :
----------------------------------------------------

[root@debian-f5ibh] ~ # cdrecord -scanbus
Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
Linux sg driver version: 3.1.19
Using libscg version 'schily-0.1'
scsibus0:
        0,0,0     0) 'GoldStar' 'CD-RW CED-8083B ' '1.05' Removable
CD-ROM
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
        0,1,0     1) 'CREATIVE' 'CD3621E  ZC100  ' '1.00' Removable
CD-ROM
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *

 And here is what I get in 2.2.20-pre5 :
---------------------------------------
[root@debian-f5ibh] ~ # cdrecord -scanbus
Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
Linux sg driver version: 3.1.19
Using libscg version 'schily-0.1'
scsibus0:
        0,0,0     0) *
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *

        0,6,0     6) 'IOMEGA  ' 'ZIP 100         ' 'L.01' Removable Disk
        0,7,0     7) *
scsibus1:
        1,0,0   100) 'GoldStar' 'CD-RW CED-8083B ' '1.05' Removable
CD-ROM
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
ide-scsi: The scsi wants to send us more data than expected - discarding
data
        1,1,0   101) 'CREATIVE' 'CD3621E  ZC100  ' '1.00' Removable
CD-ROM
        1,2,0   102) *
        1,3,0   103) *
        1,4,0   104) *
        1,5,0   105) *
        1,6,0   106) *
        1,7,0   107) *

Is this a linux administration problem [my fault] ? A cdrecord bug or a
kernel matter ?
---------
Regards
		Jean-Luc
