Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262147AbSJZONB>; Sat, 26 Oct 2002 10:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262148AbSJZONB>; Sat, 26 Oct 2002 10:13:01 -0400
Received: from smtp01.wxs.nl ([195.121.6.61]:54972 "EHLO smtp01.wxs.nl")
	by vger.kernel.org with ESMTP id <S262147AbSJZONA>;
	Sat, 26 Oct 2002 10:13:00 -0400
Message-ID: <006a01c27cfa$a167ae30$1400a8c0@Freaky>
From: "freaky" <freaky@bananateam.nl>
To: <linux-kernel@vger.kernel.org>
References: <007501c27c5d$378aef10$1400a8c0@Freaky><1035580299.13244.82.camel@irongate.s wansea.linux.org.uk> <000c01c27c6a$fe2e9b00$1400a8c0@Freaky><1035582704.12995.91.camel@irongate.swansea.linux.org.uk> <001401c27cbc$53ecf810$1400a8c0@Freaky> <1035641191.13244.108.camel@irongate.swansea.linux.org.uk>
Subject: Re: KT333, IO-APIC, Promise Fasttrak, Initrd
Date: Sat, 26 Oct 2002 16:19:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no data loss that I know off... Shouldn't I atleast have notices
something if data was overwritten? Shouldn't the partition tables be corrupt
then? (Both disk manager and linux fdisk see them correctly). Don't get me
wrong :-) I'm not saying you're wrong, I wouldn't dare :-), I just find it
strange I haven't noticed anything and I've been running this setup for
several weeks now. Is there anyway I could see this block so I can see it
actually did create it? Perhaps it's written on space unlikely to be used?

Booted into the slack rescue disk this morning (busybox) and tried email the
log but the telnet can't handle pipes or something (it didn't work :-() so
I'll guess I'll have to write the whole thing down.

fdisk did recognize all the partitions as they were on the PIIX controllers
the disks come from (on the hd[e-h] devices) I was unable to mount anything
tho' mount /dev/hdh3 /mnt/hd gave me a file doesn't exist (mnt/hd dir
exists) support for the required filesystems is compiled in.

Also, the /dev/d<x>p<y> devices didn't exist, so I probably have to create
them myself perhaps then I can mount. I'll check the files for the
major/minors.

The dmesg in busy box returned more data then the kernel itself spewed
during boot. I've never seen that before? Is it writing extra debuging info
nowadays?

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "freaky" <freaky@bananateam.nl>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Saturday, October 26, 2002 4:06 PM
Subject: Re: KT333, IO-APIC, Promise Fasttrak, Initrd


> On Sat, 2002-10-26 at 07:53, freaky wrote:
> > So that would be data on the MBR, or partition table? Perhaps win
doesn't
> > have probs because it can handle to partitions types properly. MSI told
me
>
> No its seperate. The hpt/promise raid "borrows" part of the disk and
> hides it.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


