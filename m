Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271678AbRIHWHP>; Sat, 8 Sep 2001 18:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271708AbRIHWHG>; Sat, 8 Sep 2001 18:07:06 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:62473 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S271678AbRIHWGy>; Sat, 8 Sep 2001 18:06:54 -0400
Message-Id: <200109082207.f88M7AY01188@aslan.scsiguy.com>
To: SPATZ1@t-online.de (Frank Schneider)
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors) 
In-Reply-To: Your message of "Sat, 08 Sep 2001 22:25:31 +0200."
             <3B9A7EBB.E73115AC@t-online.de> 
Date: Sat, 08 Sep 2001 16:07:10 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I run a RAID5-Array on three SCSI-Disks, all IBM, all LVD on the
>AIC7xxx-Controller on the Mobo (ASUS-P2B-DS)...and from time to time
>(usually about once per week) always the same partition of the RAID5
>gets a readerror and falls out of the array:

This is a very different issue.  The drive has even told you what is
wrong.

>-------------------------
>Sep  8 20:49:31 falcon kernel: SCSI disk error : host 0 channel 0 id 0
>lun 0 return code = 8000002
>Sep  8 20:49:31 falcon kernel: [valid=0] Info fld=0x0, Current sd08:04:
>sense key Hardware Error
>Sep  8 20:49:31 falcon kernel: Additional sense indicates Internal
				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>target failure
 ^^^^^^^^^^^^^^

Something bad happened inside the disk.  Perhaps IBM can tell you what,
but it is not the aic7xxx driver, SCSI layer, or md's fault for this
disk going offline.

>Ok, i also thought: "Bad disk" and to verify this (i have still
>guarantee on the drive) i formated it, let the AIC-BIOS do a "remap of
>bad blocks" and ran "badblocks" about 5 times on it with the

Target failures are not "media errors".  If the drive was experiencing
a media problem, it would have said so.

--
Justin
