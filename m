Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVATVkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVATVkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVATVkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:40:14 -0500
Received: from [81.23.229.73] ([81.23.229.73]:13029 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261952AbVATVkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:40:06 -0500
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Subject: Re: LVM2
Date: Thu, 20 Jan 2005 22:40:02 +0100
User-Agent: KMail/1.6.2
References: <1106250687.3413.6.camel@localhost.localdomain>
In-Reply-To: <1106250687.3413.6.camel@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200501202240.02951.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A logical volume in LVM will not handle more than 2TB. You can tie together 
the LVs in a volume group, thus going over the 2TB limit. Choose your 
filesystem well though, some have a 2TB limit too.

Disk size: What are you doing with it. 500GB disks are ATA (maybe SATA). ATA 
is good for low end servers or near line storage, SATA can be used equally to 
SCSI (I am going to suffer for this remark).

RAID5 in software works pretty good (survived a failed disk, and recovered 
another failing raid in 1 month). Hardware is better since you don't have a 
boot partition left which is usually just present on one disk (you can mirror 
that yourself ofcourse).

Regards,

Norbert van Nobelen

On Thursday 20 January 2005 20:51, you wrote:
> I recently saw Alan Cox say on this list that LVM won't handle more than
> 2 terabytes. Is this LVM2 or LVM? What is the maximum amount of disk
> space LVM2 (or any other RAID/MIRROR capable technology that is in
> Linus's kernel) handle? I am talking with various people and we are
> looking at Samba on Linux to do several different namespaces (obviously
> one tree), most averaging about 3 terabytes, but one would have in
> excess of 20 terabytes. We are looking at using 320 to 500 gigabyte
> drives in these arrays. (How? IEEE-1394. Which brings a question I will
> ask in a second email.)
>
> Is RAID 5 all that bad using this software method? Is RAID 5 available?
>
> Trever Adams
> --
> "They that can give up essential liberty to obtain a little temporary
> safety deserve neither liberty nor safety." -- Benjamin Franklin, 1759
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
