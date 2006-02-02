Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWBBQMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWBBQMW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBBQMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:12:22 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:64235 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932099AbWBBQMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:12:21 -0500
Date: Thu, 2 Feb 2006 17:12:03 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: bzolnier@gmail.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43E1D5AD.nail4MI2R8NR2@burner>
Message-ID: <Pine.LNX.4.61.0602021708330.13212@yvahk01.tjqt.qr>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner>
 <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch>
 <43DF3C3A.nail2RF112LAB@burner> <58cb370e0601310410r46210e8dvc66f631f208e9b8d@mail.gmail.com>
 <43DF678E.nail3B431CUWJ@burner> <58cb370e0601310623ic220d27q3bfd4642cd0538fb@mail.gmail.com>
 <Pine.LNX.4.61.0602011630440.22529@yvahk01.tjqt.qr> <43E1D5AD.nail4MI2R8NR2@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Which unfortunately leads us back to one of the early questions.
>>
>> If ATAPI is some sort of SCSI [command set] over ATA, and ide-cd can be used
>> without the "Big Bad" SCSI layer (CONFIG_SCSI), don't we have redundant code
>> floating around?
>
>CONFIG_SCSI???
>

What else?

>Why not using fully dynamical loadable kernel modules as done with Solaris 

Do you think I have scsi built-in? Not at all.

lsmod::
sg                     20120  0
sd_mod                 12304  0
usb_storage            73408  0
usbcore               108256  5 uhci_hcd,ohci_hcd,ehci_hcd,usb_storage
scsi_mod              103496  3 sg,sd_mod,usb_storage

/proc/config.gz:
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_CONSTANTS=y

that's about all.

>since 1992? Since that time nobody cares because what you need is auto-loaded 
>on demand and there is absolutely no need for a manual configuration.


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
