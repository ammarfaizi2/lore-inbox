Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSKZXx6>; Tue, 26 Nov 2002 18:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbSKZXx6>; Tue, 26 Nov 2002 18:53:58 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:59795 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261686AbSKZXx4>; Tue, 26 Nov 2002 18:53:56 -0500
Subject: Re: 2.5.49: Severe PIIX4/ATA filesystem corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <as0nq9$vnu$1@cesium.transmeta.com>
References: <as0nq9$vnu$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 00:32:26 +0000
Message-Id: <1038357146.2658.105.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 21:07, H. Peter Anvin wrote:
> So, I finally braved it and tried running 2.5.49 on my workstation to
> test out my RAID-6 patches.  There were no patches outside the md
> area, and the ordinary filesystems aren't on md drives.
> 
> The two SCSI drives (SymBIOS controller) work just fine, but I have
> gotten repeated, severe data corruption on the one ATA drive in the
> system after only a few hours of operation.

If you mash the innards of the page cache you'll get corruption
everywhere, its one of the charms of testing out that area of the code
on Linux. You might want to debug using 2.5.49 user mode linux rather
than on raw disks. Its so much easier to use "cp" to generate a
replacement root_fs 8)


Alan

