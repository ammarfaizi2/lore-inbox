Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130698AbRCMG32>; Tue, 13 Mar 2001 01:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130920AbRCMG3S>; Tue, 13 Mar 2001 01:29:18 -0500
Received: from think.faceprint.com ([166.90.149.11]:9221 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S130698AbRCMG3D>; Tue, 13 Mar 2001 01:29:03 -0500
Message-ID: <3AADBDFA.B65047EB@faceprint.com>
Date: Tue, 13 Mar 2001 01:28:10 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac20
In-Reply-To: <E14cgXm-0003O5-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
>         ftp://ftp.kernel.org/pub/linux/kernel/people/alan/3.4/
> 
>                 Intermediate diffs are available from
> 
>                         http://www.bzimage.org
> 
> (Note that the cmsfs port to 2.4 is a work in progress)
> 
> Its now 2767631 bytes .gz but a fair amount of stuff has gone to Linus so
> if you redo the diff versus 2.4.3pre4 it looks a lot nicer 8)
> 
> 2.4.2-ac20
> o       Add support for the GoHubs GO-COM232            (Greg Kroah-Hartman)
> o       Remove cobalt remnants                          (Ralf Baechle)
> o       First block of mm documentation                 (Rik van Riel)
> o       Replace ancient Zoran driver with new one       (Serguei Miridonov,
>                                 Wolfgang Scherr, Rainer Johanni, Dave Perks)
> o       Fix Alpha build                                 (Jeff Garzik)
> o       Fix K7 mtrr breakage                            (Dave Jones)
> o       Fix pcnet32 touching resources before enable    (Dave Jones)
> o       Merge with Linus 2.4.3pre4


Debian sid (unstable).  ac18 compiled fine.  ac20, i got this:

gcc -I/usr/include -ldb aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c -o aicasm
aicasm/aicasm_gram.y:45: ../queue.h: No such file or directory
aicasm/aicasm_gram.y:50: aicasm.h: No such file or directory
aicasm/aicasm_gram.y:51: aicasm_symbol.h: No such file or directory
aicasm/aicasm_gram.y:52: aicasm_insformat.h: No such file or directory
aicasm/aicasm_scan.l:44: ../queue.h: No such file or directory
aicasm/aicasm_scan.l:49: aicasm.h: No such file or directory
aicasm/aicasm_scan.l:50: aicasm_symbol.h: No such file or directory
aicasm/aicasm_scan.l:51: y.tab.h: No such file or directory
make[5]: *** [aicasm] Error 1
make[5]: Leaving directory
`/usr/src/linux-2.4.2-ac20/drivers/scsi/aic7xxx/aicasm'
make[4]: *** [aicasm/aicasm] Error 2
make[4]: Leaving directory
`/usr/src/linux-2.4.2-ac20/drivers/scsi/aic7xxx'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory
`/usr/src/linux-2.4.2-ac20/drivers/scsi/aic7xxx'
make[2]: *** [_subdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.2-ac20/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.2-ac20/drivers'
make: *** [_dir_drivers] Error 2
patience:/usr/src/linux# 



Also, sometime between ac7 and ac18 (spring break kept me from testing
stuff inbetween), i assume during the new aic7xxx driver merge, the
order of detection got changed, and now the ide-scsi virtual host is
host0, and my 29160N is host1.  Is this on purpose?  It messed up a
bunch of my stuff as far as /dev and such are concerned.  


Thanks,
Nathan
