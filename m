Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755050AbWKLLM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050AbWKLLM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 06:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755051AbWKLLM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 06:12:29 -0500
Received: from maya.ngi.it ([88.149.128.3]:31388 "EHLO maya.ngi.it")
	by vger.kernel.org with ESMTP id S1755050AbWKLLM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 06:12:28 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA ICH5 not detected at boot, mm-kernels
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
References: <200611051536.35333.cova@ferrara.linux.it> <20061105161725.1a326135.akpm@osdl.org> <454F2E0F.3010804@gmail.com>
In-Reply-To: <454F2E0F.3010804@gmail.com>
MIME-Version: 1.0
Date: Sun, 12 Nov 2006 12:09:28 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611121209.31502.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that my message hasn't yet shown up on lkml, so I suppose to have 
some mail problem :(

To see if this helps, I've removed attachments, replacing it with urls.


Alle 13:43, lunedì 6 novembre 2006, Tejun Heo ha scritto:
> Hello,
>
> Andrew Morton wrote:
> > On Sun, 5 Nov 2006 15:36:33 +0100
> >
> > Fabio Coatti <cova@ferrara.linux.it> wrote:
> >> Hi all; It seems that problems like this has been already reported, but
> >> not exactly the same, so maybe thsi can add some infos. Otherwise, sorry
> >> for the noise.
> >>
> >> Starting from 2.6.19-rc1-mm1 and up to rc4-mm2, at boot the kernel is
> >> unable to detect two sata disks, connected to a ICH5 controller. Latest
> >> mm working kernel seems to be 2.6.18-mm3; 2.6.19-rc4 works just fine.
> >>

I've collected more data; Here you can find .config for all three cases:

2.6.18-mm3 (working) http://members.ferrara.linux.it/cova/config-2.6.18-mm3
2.6.19-rc5 (working) http://members.ferrara.linux.it/cova/config-2.6.19-rc5
2.6.19-rc5-mm1 (not working) 
http://members.ferrara.linux.it/cova/config-2.6.19-rc5-mm1

and dmesg for 2.6.18-mm3 and 2.6.19-rc5. I've seen that I've saved the dmesg 
with nvidia driver inserted; I can't, right now, recreate the files without 
nvidia driver loaded, but as the issue happens before the driver is loaded 
maybe the information can be useful anyway. I'll made a non tainted dmesg as 
soon as possible, if needed.

http://members.ferrara.linux.it/cova/dmesg-2.6.18-mm3
http://members.ferrara.linux.it/cova/dmesg-2.6.19-rc5

I'm trying to get the dmesg for 2.6.19-rc-mm1 (the non-working one), but I've 
to find a serial cable :)

Anyway, I've seen this message on dmesg, that seems interesting (copied by 
hand, please forgive any mistake):

PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
ata_piix: probe of 0000:00:1f.2 failed with error -16

Of course, lspci for that device gives:

00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 
02) (prog-if 8a [Master SecP PriP])
        Subsystem: ABIT Computer Corp. Unknown device 1014
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 17
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at f000 [size=16]


HTH

-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
