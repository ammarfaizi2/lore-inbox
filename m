Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLFUMz>; Wed, 6 Dec 2000 15:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130499AbQLFUMp>; Wed, 6 Dec 2000 15:12:45 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:8202
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129231AbQLFUMa>; Wed, 6 Dec 2000 15:12:30 -0500
Date: Wed, 6 Dec 2000 11:41:51 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Trashing ext2 with hdparm
In-Reply-To: <3A2E767B.D74B24B5@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.LNX.4.10.10012061141300.21407-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No way that this could cause corruption it is a read-only test.

On Wed, 6 Dec 2000, Udo A. Steinberg wrote:

> 
> Hi,
> 
> Following the discussion in another thread where someone
> reported fs corruption when enabling DMA with hdparm, I've
> played around with hdparm and found that even the rather
> harmless hdparm operations are capable of trashing an ext2
> filesystem quite nicely.
> 
> hdparm version is 3.9
> 
> hdparm -tT /dev/hdb1 does the trick here.
> 
> After that, several files are corrupted, such as /etc/mtab.
> Reboot+fsck fixes the problem, however e2fsck never finds
> any errors in the fs on disk.
> 
> I'm quite sure that earlier kernel versions didn't exhibit
> this kind of behaviour, although I'm not quite sure at
> which point things started to break. I have test12-pre6
> here atm, but I have test-11 still lying around and will
> test that in a bit.
> 
> The drive in question is an IBM-DTLA307030 running in
> UDMA Mode 5 on a PDC20265, chipset revision 2.
> 
> I haven't seen any other corruption other than that which
> hdparm reliably triggers. Might as well be a bug in hdparm,
> so someone else might also want to check...
> 
> -Udo.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
