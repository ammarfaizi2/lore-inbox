Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288028AbSAMTem>; Sun, 13 Jan 2002 14:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288040AbSAMTed>; Sun, 13 Jan 2002 14:34:33 -0500
Received: from tourian.nerim.net ([62.4.16.79]:45585 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S288028AbSAMTeT>;
	Sun, 13 Jan 2002 14:34:19 -0500
Message-ID: <3C41E139.8080603@inet6.fr>
Date: Sun, 13 Jan 2002 20:34:17 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020111
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan <wfilardo@fuse.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 Unable to boot on Cyrix box?
In-Reply-To: <3C406C21.3050208@fuse.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:

> Hi.
>
> I have an old recycled box playing firewall for me which stubbornly 
> refuses to run 2.4.  2.2.17,18,19,20 and a handful of -pre* patches 
> have run just fine.
>
> The system just hangs after 2.4 prints out:
> SIS5513: IDE controller on PCI bus 00 dev 09
> SIS5513: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:pio, hdb:pio
>    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:pio, hdd:pio
> hda: Maxtor 90320D2, ATA DISK drive
> hdb: CD-ROM CDU76E, ATAPI CDROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 


- Did you try with ide=nodma ?
- I've not yet read the full specs of old SiS IDE chips, but there is a 
bug for ATA66 and 33 chips in the stock kernel. Try copying 
http://gyver.homeip.net/sis5513/sis5513-limited.c over your 
linux/drivers/ide/sis5513.c. It fixes the bug above and will output your 
IDE Config registers and each change it makes. Please send me the 
"SIS5513: " lines if you can (I'm interested in cases of failure and 
success).

>
> Relevant system specs:
> Cyrix 233MHz processor
> 64M PC-100 RAM (1 dimm)
> SIS5513 IDE chipset
>    LSPCI reports: 00:01.1 IDE interface: Silicon Integrated Systems 
> [SiS] 5513 [IDE] (rev d0)

Do you have the motherboard model ?

>
>
> I have the kernel built for a 386, PCI and EISA support enabled (and 
> their respective PNP) all Y, SIS5513 support included in the kernel... 
> What am I missing, here?


Perhaps correct init code in sis5513.c for your chip. Send me all info 
requested above and I'll try to sort it out.

>
> More information available if needed.
>
The more you send me, the better.

LB.

