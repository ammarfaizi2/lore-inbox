Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273935AbRIRVSL>; Tue, 18 Sep 2001 17:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273936AbRIRVSB>; Tue, 18 Sep 2001 17:18:01 -0400
Received: from mail.missioncriticallinux.com ([208.51.139.18]:42257 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S273935AbRIRVR5>; Tue, 18 Sep 2001 17:17:57 -0400
Message-ID: <3BA7BA06.B7E61F63@MissionCriticalLinux.com>
Date: Tue, 18 Sep 2001 14:17:58 -0700
From: Bruce Blinn <blinn@MissionCriticalLinux.com>
Organization: Mission Critical Linux
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.6-cdrom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Wojtek Pilorz <wpilorz@bdk.pl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, root@chaos.analogic.com,
        Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <Pine.LNX.4.21.0109181248480.22180-100000@celebris.bdk.pl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wojtek Pilorz wrote:
> 
> Could you try
> cdrecord -toc dev=x,y
> where x,y are numbers returned for your SCSI (either native or emulated)
> device by
>  cdrecord -scanbus

I think I finally got the cdrecord command to work (thanks Tobias).  By
the way, after today, I will be on vacation until Monday, so if I don't
reply to messages, don't think that it is that I do not appreciate all
the help that I am getting.

Thanks,
Bruce

# cdrecord -scanbus
Cdrecord 1.8 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
Using libscg version 'schily-0.1'
scsibus0:
cdrecord: Warning: controller returns wrong size for CD capabilities
page.
        0,0,0     0) 'Lite-On ' 'LTN483S 48x Max ' 'PD02' Removable
CD-ROM
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
# cdrecord -toc dev=0,0,0
Cdrecord 1.8 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
scsidev: '0,0,0'
scsibus: 0 target: 0 lun: 0
Using libscg version 'schily-0.1'
cdrecord: Warning: controller returns wrong size for CD capabilities
page.
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'Lite-On '
Identifikation : 'LTN483S 48x Max '
Revision       : 'PD02'
Device seems to be: Generic mmc CD-ROM.
cdrecord: Warning: controller returns wrong size for CD capabilities
page.
cdrecord: Warning: controller returns wrong size for CD capabilities
page.
cdrecord: Warning: controller returns wrong size for CD capabilities
page.
Using generic SCSI-3/mmc CD driver (mmc_cd).
Driver flags   : SWABAUDIO
first: 1 last 2
track:   1 lba:         0 (        0) 00:02:00 adr: 1 control: 6 mode: 2
track:   2 lba:       512 (     2048) 00:08:62 adr: 1 control: 5 mode: 2
track:lout lba:     14144 (    56576) 03:10:44 adr: 1 control: 5 mode:
-1
#
