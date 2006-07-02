Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWGBDuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWGBDuy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 23:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWGBDuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 23:50:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:51614 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751803AbWGBDux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 23:50:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ilBww65CHnGuzNfu4FDm7Fcfo+vz4cOPyq7ePwEl31WoYXGsYXdITkKWt1d5lMfwogtL/gastDxEqpVPQmc3uUykneEqEeIJtJ5//fToUaC9JD9+3nh5iRX7CKGhZJxotc2umngM13jS1urIdjxyE2m0x2qCUWGaO0QjqR7N2mk=
Message-ID: <44A742BC.2000500@gmail.com>
Date: Sun, 02 Jul 2006 12:51:24 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.17-mm5 dislikes raid-1, just like mm4
References: <20060701033524.3c478698.akpm@osdl.org> <20060701181455.GA16412@aitel.hist.no>
In-Reply-To: <20060701181455.GA16412@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> md:  adding sda2 ...
> md: created md0
> md: bind<sda2>
> md: bind<sdb1>
> md: running: <sdb1><sda2>
> raid1: raid set md0 active with 2 out of 2 mirrors
> md: ... autorun DONE.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
>   Vendor: USB2.0    Model:       HS-CF       Rev: 1.64
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> sd 3:0:0:0: Attached scsi removable disk sdf
> sd 3:0:0:0: Attached scsi generic sg5 type 0
>   Vendor: USB2.0    Model:       HS-MS       Rev: 1.64
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> sd 3:0:0:1: Attached scsi removable disk sdg
> sd 3:0:0:1: Attached scsi generic sg6 type 0
>   Vendor: USB2.0    Model:       HS-SM       Rev: 1.64
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> sd 3:0:0:2: Attached scsi removable disk sdh
> sd 3:0:0:2: Attached scsi generic sg7 type 0
>   Vendor: USB2.0    Model:       HS-SD/MMC   Rev: 1.64
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> sd 3:0:0:3: Attached scsi removable disk sdi
> sd 3:0:0:3: Attached scsi generic sg8 type 0
> usb-storage: device scan complete
> loadkeys[2214]: segfault at 00000000000005a0 rip 00002b22e169feea rsp 00007fffc973c478 error 4
> Adding 1000424k swap on /dev/sda6.  Priority:1 extents:1 across:1000424k
> EXT3 FS on sdd1, internal journal
> raid1: Disk failure on sda2, disabling device. 
>         Operation continuing on 1 devices
> RAID1 conf printout:
>  --- wd:1 rd:2
>  disk 0, wo:1, o:0, dev:sda2
>  disk 1, wo:0, o:1, dev:sdb1
> RAID1 conf printout:
>  --- wd:1 rd:2
>  disk 1, wo:0, o:1, dev:sdb1
> raid1: Disk failure on sda5, disabling device. 
>         Operation continuing on 1 devices
> RAID1 conf printout:
>  --- wd:1 rd:2
>  disk 0, wo:1, o:0, dev:sda5
>  disk 1, wo:0, o:1, dev:sdb5
> RAID1 conf printout:
>  --- wd:1 rd:2
>  disk 1, wo:0, o:1, dev:sdb5
> raid1: Disk failure on sde2, disabling device. 
>         Operation continuing on 1 devices
> RAID1 conf printout:
>  --- wd:1 rd:2
>  disk 0, wo:1, o:0, dev:sde2
>  disk 1, wo:0, o:1, dev:sdd2
> RAID1 conf printout:
>  --- wd:1 rd:2
>  disk 1, wo:0, o:1, dev:sdd2
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on md3, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda8, internal journal
> EXT3-fs: mounted filesystem with writeback data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on md2, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on md0, internal journal
> EXT3-fs: mounted filesystem with journal data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with writeback data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on sda7, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> PM: Writing back config space on device 0000:00:0b.0 at offset b (was 165314e4, writing 13001462)
> PM: Writing back config space on device 0000:00:0b.0 at offset 3 (was 0, writing 2008)
> PM: Writing back config space on device 0000:00:0b.0 at offset 2 (was 2000000, writing 2000003)
> PM: Writing back config space on device 0000:00:0b.0 at offset 1 (was 2b00000, writing 2b00006)
> ADDRCONF(NETDEV_UP): eth0: link is not ready
> [...]
> 
> As we see, the md devices are assembled, then the filesystems are
> mounted and swap turned on.  Then all three md devices fail a 
> partition at the same time.  Somehow, I don't believe that
> is correct. ;-)

Hello, all,

I've just tested both libata-dev#upstream and 2.6.17-mm5 and both work 
fine on my machine w/ sata_sil24.  It doesn't seem to be a libata 
problem ATM.  libata should have complained loud & clear if it had 
indicated error to upper layer thus causing above degraded raid array 
event.  Can you please post full boot dmesg preferably w/ timestamps?

Thanks.

-- 
tejun
