Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292601AbSBUBXA>; Wed, 20 Feb 2002 20:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292605AbSBUBWl>; Wed, 20 Feb 2002 20:22:41 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:10767
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S292601AbSBUBW2>; Wed, 20 Feb 2002 20:22:28 -0500
Date: Thu, 21 Feb 2002 02:21:54 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Diego Calleja <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hang in 2.4.18-rc2-ac1
Message-ID: <20020221022154.A6241@bouton.inet6-interne.fr>
Mail-Followup-To: Diego Calleja <diegocg@teleline.es>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020220192127.622006ff.diegocg@teleline.es> <E16dcvN-0004YR-00@the-village.bc.nu> <20020220213715.0a741080.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020220213715.0a741080.diegocg@teleline.es>; from diegocg@teleline.es on Wed, Feb 20, 2002 at 09:37:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 09:37:15PM +0100, Diego Calleja wrote:

> [...
> Chipset is SIS 5571, ide chipset SIS 5513. I've some problems with
> latest updates about SIS Ide driver update: When I sleep the drive with
> hdparm -Y /dev/hda
> then the drive sleeps. But it doesn't 'awake'. I can do 'Login: XXX \n Password: XXX' or write a command
> in the shell. But when the unit has to read/write, it just does nothing.
> 
> Latest kernels without this patch (2.4.18-preX....) did something different:
> I could sleep drive normally. But when the system had to read/write something:
> 
> Feb 15 18:13:08 localhost kernel: hda: timeout waiting for DMA
> Feb 15 18:13:08 localhost kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> Feb 15 18:13:08 localhost kernel: hda: status timeout: status=0xd0 { Busy }
> Feb 15 18:13:08 localhost kernel: hda: drive not ready for command
> Feb 15 18:13:08 localhost kernel: ide0: reset: success
> 
> The system just stopped a few seconds, and then it started as always.
> [...]

I don't know anything about the SiS5571 yet, please send me your boot logs related
to SiS IDE (you can't miss them...). If you know what your chip
capabilities are (see your motherboard doc, ATA33/66/100 should
be printed somewhere if the chipset supports these ATA generations).
As the driver is not yet aware of this chip it defaults to
original SiS5513 behaviour, this is most probably the source of your problem.

LB.
