Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278039AbRJOTNE>; Mon, 15 Oct 2001 15:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278030AbRJOTMz>; Mon, 15 Oct 2001 15:12:55 -0400
Received: from tunnel-44-183.vpn.uib.no ([129.177.44.183]:54920 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S278039AbRJOTMm>; Mon, 15 Oct 2001 15:12:42 -0400
Message-ID: <3BCB36A7.7020909@fi.uib.no>
Date: Mon, 15 Oct 2001 21:19:03 +0200
From: Igor Bukanov <boukanov@fi.uib.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: John J Tobin <ogre@sirinet.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE DVD problem under 2.4: status=0x51 { DriveReady SeekComplete Error } (fwd)
In-Reply-To: <Pine.OSF.3.96.1011015132315.30364A-100000@asfys3.fi.uib.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John J Tobin wrote:

> On Sun, 2001-10-14 at 20:32, Igor Bukanov wrote:
> 
>>I tried to setup my Dell Inspiron 7500 notebook (Celeron 466/512MB) with 
>>TORiSAN DVD-ROM DRD-U62 (RPC-2 drive :-( ) to watch DVD and found the 
>>following when using decss to read the encrypted vob files (other ways 
>>to access the file eventually produce the same error) under  2.4.12 
>>kernel, RedHat Linux 7.1. After I authenticated the drive and got a 
>>title key for some file, css-cat always fails on the first 2-3 attempts 
>>to read the file due to input-output error with kernel message:
>>
>>hdc: command error: status=0x51 { DriveReady SeekComplete Error }
>>hdc: command error: error=0x50
>>end_request: I/O error, dev 16:00 (hdc), sector 563008
>>
>>
> Under the IDE/ATAPI configuration stuff in the kernel configuration
> select the option "Use multi-mode by default." That may solve your
> problem.				


I already have that option on:
CONFIG_IDEDISK_MULTI_MODE=y

Should I try with this option disabled???

Here are uncommented line from my .config IDE section:
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

Regards, Igor

