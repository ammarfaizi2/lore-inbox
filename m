Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132575AbRDKNTP>; Wed, 11 Apr 2001 09:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132574AbRDKNTF>; Wed, 11 Apr 2001 09:19:05 -0400
Received: from linux.kappa.ro ([194.102.255.131]:10627 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S132575AbRDKNS6>;
	Wed, 11 Apr 2001 09:18:58 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: linux.kappa.ro
Date: Wed, 11 Apr 2001 16:18:53 +0300
From: Mircea Damian <dmircea@kappa.ro>
To: lomarcan@tin.it
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SCSI tape corruption problem
Message-ID: <20010411161853.F4540@linux.kappa.ro>
In-Reply-To: <20010411113702.GURC24736.fep04-svc.tin.it@fep41-svc.tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010411113702.GURC24736.fep04-svc.tin.it@fep41-svc.tin.it>; from lomarcan@tin.it on Wed, Apr 11, 2001 at 01:37:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This seems to happen on my system too but I have and IDE tape:

Apr  3 00:00:48 www kernel: ide-tape: hdb <-> ht0: Seagate STT8000A rev 5.02
Apr  3 00:00:48 www kernel: ide-tape: hdb <-> ht0: 600KBps, 14*26kB buffer, 5850kB pipeline, 80ms tDSC, DMA


I have managed to recover the tar archive by writing the data through a
faucet pipe on another machine.

So this seems to be a problem only when I write the data on the same IDE
interface.

On Wed, Apr 11, 2001 at 01:37:02PM +0200, lomarcan@tin.it wrote:
> I've recently installed a SDT-9000 tape drive. Running kernel 2.4.x I've
> noticed the following (critical) problem:
> 
> Apparently the data are corrupted on the way to (from?) tape. I'm sure the
> DAT 
> drive is good (worked good on NT, head clean, new cartridge). It doesn't
> report
> data errors. I've got bad CRC errors on tar (the gzip part, of course)
> 
> The drive is on an Adaptec 2904 controller, with a Yamaha CDRW on the same
> bus.
> I'm pretty sure it's terminated correctly. Another SCSI controller (2940)
> is 
> driving 2 hard drives. Underlying HW: Athlon 1GHz, on Asus board (VIA
> chipset). 
> It seems to happen frequently (tried four times with about 600MB of data,
> three
> times failed the restore :((. Tried all the 2.4.x kernel series (thru
> 2.4.3)
> 
> What can it be? (I'll try to compare the read data with the original...)
> 
> 				-- Lorenzo Marcantonio
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
