Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752271AbWCNHcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbWCNHcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 02:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbWCNHcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 02:32:00 -0500
Received: from math.ut.ee ([193.40.36.2]:22228 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1752271AbWCNHb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 02:31:59 -0500
Date: Tue, 14 Mar 2006 09:31:56 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: New libata PATA patch for 2.6.16-rc1
In-Reply-To: <1142299273.25773.39.camel@localhost.localdomain>
Message-ID: <Pine.SOC.4.61.0603140927050.17208@math.ut.ee>
References: <20060313195722.6ADBF1401F@rhn.tartu-labor> 
 <Pine.SOC.4.61.0603132202080.14431@math.ut.ee> <1142299273.25773.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Built an universla kernel with alla PATA drivers and netconsole, to test
>> on some machines. Just finished building and tried it in qemu, with
>> different config than before. It still crashes in qemu. dmesg and
>> .config below. It seems to detect PDC20230-C/20630 VLB ATA controller
>> that is not there, and then crash in legacy_init(?).
>
> Interesting. If you compile the legacy driver out does it then run
> properly. If you've got an IDE class device legacy should not be loading
> so I'll have a look at that.

Even stranger. I disabled CONFIG_SCSI_PATA_LEGACY and left all other 
SATA and PATA options to Y and not it does not detect any ATA at all in 
qemu - not even the PDC. Qemu is 0.8.0-2 Debian package, using command 
line
qemu -nographic -cdrom patatest.iso -hda hdd -boot d
hdd is a 800M image file.

-- 
Meelis Roos (mroos@linux.ee)
