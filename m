Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSFOTuM>; Sat, 15 Jun 2002 15:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSFOTuM>; Sat, 15 Jun 2002 15:50:12 -0400
Received: from moutvdomng0.kundenserver.de ([195.20.224.130]:37616 "EHLO
	moutvdomng0.schlund.de") by vger.kernel.org with ESMTP
	id <S315483AbSFOTuK>; Sat, 15 Jun 2002 15:50:10 -0400
Message-Id: <5.0.2.1.2.20020615213722.038c4940@pop.puretec.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sat, 15 Jun 2002 21:49:50 +0200
To: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>,
        Linux SCSI list <linux-scsi@vger.kernel.org>
From: Sancho Dauskardt <sancho@dauskardt.de>
Subject: Re: /proc/scsi/map
Cc: linux-usb-devel@lists.sourceforge.net,
        linux1394-devel@lists.sourceforge.net
In-Reply-To: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Life would be easier if the scsi subsystem would just report which SCSI
>device (uniquely identified by the controller,bus,target,unit tuple) belongs
>to which high-level device. The information is available in the kernel.
>
>Attached patch does this:
>garloff@pckurt:/raid5/Kernel/src $ cat /proc/scsi/map
># C,B,T,U       Type    onl     sg_nm   sg_dev  nm      dev(hex)
>0,0,00,00       0x05    1       sg0     c:15:00 sr0     b:0b:00
[...]

Great, this was really missing badly.

But how about adding another column: GUID.
Most usb-storage and (all?) FireWire devices have such a unique identitiy.
In contrast to native SCSI devices, these emulated SCSI devices on 
hot-plugging busses will change their LUNs/IDs. Therefor the GUID is really 
a must to be able to create stable names (laptop suspend, etc.).

Both usb-storage and iee1394-sbp2 know the GUID. It only needs to be 
communicated..

I'd guess that FibreChannel has similar problems ?

- sda

