Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbUDONCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 09:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbUDONCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 09:02:49 -0400
Received: from smtp.rol.ru ([194.67.21.9]:30430 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S263825AbUDONCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 09:02:44 -0400
From: Konstantin Sobolev <kos@supportwizard.com>
Reply-To: kos@supportwizard.com
Organization: SupportWizard
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: poor sata performance on 2.6
Date: Thu, 15 Apr 2004 17:05:23 +0400
User-Agent: KMail/1.6.1
Cc: Lenar =?iso-8859-1?q?L=F5hmus?= <lenar@vision.ee>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <200404150236.05894.kos@supportwizard.com> <200404151440.23858.kos@supportwizard.com> <200404151537.38739.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200404151537.38739.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404151705.23753.kos@supportwizard.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 16:37, Denis Vlasenko wrote:
> > /dev/sda:
> >  setting fs readahead to 8192
> >  readahead    = 8192 (on)
> >  Timing buffered disk reads:   84 MB in  3.06 seconds =  27.46 MB/sec
>
> 27 Mb/s is not 'very' bad for 80Gb drive.
>
> Can you verify that drive indeed is able to do better
> (quick test under Windows is in order)? It would be silly
> to try to hunt down problem which do not exist.

Here's this drive benchmarks under Windows on almost the same SATA controller:

http://www.tomshardware.com/storage/20040123/wd740-01.html
actual numbers:
http://www.tomshardware.com/storage/20040123/wd740-08.html

It appears to be the fastest SATA drive up to the moment, I expected to get 
something around 60-70 MB/sec

>
> If problem does exist, try 2.4 kernels.

I tried 2.4.25. There is no sata_sil driver there. siimage driver detects the 
controller but doesn't detect the disk:

SiI3112 Serial ATA: IDE controller at PCI slot 00:0f.0
PCI: Found IRQ 12 for device 00:0f.0
PCI: Sharing IRQ 12 with 00:0a.0
PCI: Sharing IRQ 12 with 00:10.2
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio

that's all

-- 
/KoS
* A fool and his money are my kind of customer.			      
