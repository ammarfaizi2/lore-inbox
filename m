Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287894AbSAPV1t>; Wed, 16 Jan 2002 16:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287882AbSAPV1d>; Wed, 16 Jan 2002 16:27:33 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9642 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S287881AbSAPV0U>;
	Wed, 16 Jan 2002 16:26:20 -0500
Date: Wed, 16 Jan 2002 13:07:46 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: john e weber <john@worldwideweber.org>
cc: linux-kernel@vger.kernel.org
Subject: DO NOT USE IT (Re: linux-2.5.3-pre1 and IDE Driver Trouble) FATAL
In-Reply-To: <Pine.LNX.4.33.0201091206030.2530-100000@worldwideweber.org>
Message-ID: <Pine.LNX.4.10.10201161259270.29434-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is a problem that is bigger than simplely issueing a simple
setfeatures non-data-pio command.  All of the PIO data-phases are broken.
Nothing works but DMA, and there is no reason it should fail.

Something has gone totally wrong between the 2.5.1 patch submitted to it
being applied for the creation of 2.5.3-pre1.

If the driver falls out of DMA, DEADBOX!!!!
There is a conflict of BIO and ACB and it is very fatal.

Therefore I will have to withdraw the patch and resubmit with the legacy
data-path added back so the kernel development can continue.

The only kernel in the development series known to work is 2.5.1.
However it appears that several people can not successfully use this
CodeBase either.

Until I can submit a new patch witch is a replacement, do not attempt
2.5.3-pre1 at all.

On Wed, 16 Jan 2002, john e weber wrote:

> 
> linux-2.5.3-pre1 freezes when using hdparm.
> The exact command issued:
> /sbin/hdparm -m16 -d1 -c3 -A1 /dev/hda
> 
> Specifically, it freezes when attempting to set multimode (hdparm -m16);
> all other options work fine.
> 
> This doesn't seem to be a big problem, as I have my kernel configured to   
> use multi-mode by default.  So the kernel sets it to the right value (16) 
> by default.
> 
> It doesn't print any messages, so please let me know if there
> is anything else I should try.
> 
> I keep forgetting to send all my system info with my emails, so:
> 
> Linux 2.5.3-pre1
> GCC 2.96-98
> 128 MB RAM
> Pentium III, Intel 443BX System Chipset (Intel PIIX4 IDE Interface)
> 
> --
> John Weber
> (AKA weber@nyc.rr.com)                                    HOME
> (AKA weber@cs.ccny.cuny.edu)                       WORK/SCHOOL
> (AKA The NOTORIOUS BIG ENDIAN)             ALL AROUND DA WORLD
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

