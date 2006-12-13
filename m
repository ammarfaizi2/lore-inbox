Return-Path: <linux-kernel-owner+w=401wt.eu-S1750706AbWLMU5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWLMU5Z (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWLMU5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:57:24 -0500
Received: from webserve.ca ([69.90.47.180]:39010 "EHLO computersmith.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750706AbWLMU5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:57:23 -0500
Message-ID: <458068E2.1050601@wintersgift.com>
Date: Wed, 13 Dec 2006 12:56:02 -0800
From: Teunis Peters <teunis@wintersgift.com>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question: SATA and Flash drives?  (also: dm-crypto problem)
References: <45805A46.7090505@wintersgift.com> <45806040.4000300@garzik.org>
In-Reply-To: <45806040.4000300@garzik.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik wrote:
> Teunis Peters wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> I'm now getting a long delay on bootup on SATA-based laptops.  (30
>> seconds +) followed by some unusual errors.
> 
> Does this delay still occur in 2.6.19-git10 or later?

as of git-17 - yes.
I'm trying git linux/kernel/git/torvalds/linux-2.6.git now to see if that helps.

it did NOT happen with compact-flash on SATA adaptor as of 2.6.19 plain - but that kernel had piles of other problems on the hardware in question so I updated.   It's down to this
delay and a few other nagles before the system's ready for the world.   I also didn't have the 16G SATA/Flash drive then.

I'm hoping the log files help.   It's Intel 82801GBM/GHM (ICH7) hardware if that helps.

- - Teunis

PS: just the ATA log from 2.6.19-git6 - which does boot:  (I can get more info from that - as it's possible to save the logs and email them)
libata version 2.00 loaded.
hda: HL-DT-STCD-RW/DVD DRIVE GCC-4244N, ATAPI CD/DVD-ROM drive
hda: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA mode
ata1: SATA max UDMA/133 cmd 0xF0808100 ctl 0x0 bmdma 0x0 irq 222
ata2: SATA max UDMA/133 cmd 0xF0808180 ctl 0x0 bmdma 0x0 irq 222
ata3: SATA max UDMA/133 cmd 0xF0808200 ctl 0x0 bmdma 0x0 irq 222
ata4: SATA max UDMA/133 cmd 0xF0808280 ctl 0x0 bmdma 0x0 irq 222
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1: port is slow to respond, please be patient (Status 0x80)
ata1: port failed to respond (30 secs, Status 0x80)
ata1: COMRESET failed (device not ready)
ata1: hardreset failed, retrying in 5 secs
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6, max UDMA/33, 32503808 sectors: LBA
ata1.00: ata1: dev 0 multi count 1
ata1.00: applying bridge limits
ata1.00: configured for UDMA/33
ata2: SATA link down (SStatus 0 SControl 0)
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      PQI SATA DiskOnM YUAN PQ: 0 ANSI: 5
EXT3-fs: mounted filesystem with ordered data mode.
ieee80211: 802.11 data/management/control stack, git-1.1.13
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs: mounted filesystem with ordered data mode.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgGjibFT/SAfwLKMRApxgAJ9ipA+b5HwXSCJhzL4hMfrgiFXotgCdGweJ
7cs7FtttmjP8NkYdzs1XN8Y=
=yXkx
-----END PGP SIGNATURE-----
