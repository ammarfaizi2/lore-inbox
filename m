Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751139AbWFEPMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWFEPMX (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 11:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWFEPMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 11:12:23 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:13529 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751139AbWFEPMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 11:12:22 -0400
Message-ID: <02e001c688b2$695e9400$1800a8c0@dcccs>
From: "Janos Haar" <djani22@netcenter.hu>
To: "Janos Haar" <djani22@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>
References: <011c01c6888a$a0a881a0$1800a8c0@dcccs>
Subject: Re: critical bug in sata driver ?
Date: Mon, 5 Jun 2006 17:12:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Janos Haar" <djani22@netcenter.hu>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, June 05, 2006 12:27 PM
Subject: critical bug in sata driver ?


> Hello, list,
>
> I have a reproducible _software_ bug about sata. (libata?)
>
> In my system i have 4 nodes, each has 12 hdd.
> All hw are equal, and 110% tested, and really error free!
>
> But 2 of my nodes, frequently reboots without and any error message on
> remote syslog, and netconsole.
> No oops, no nothing!
> (loglevel 9)
>
> Only in serial console can show some time a little clue:
>
> "ata2: translated ATA stat/err 0x51/40 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata2: status=0x51 { DriveReady SeekComplete Error"
>
> After this little partial message, the system immediately reboots!
>
> Thats the all.
>
> The smart log is clear in _all_ my 48 hdd.
> Anyway the disk and cable in ata2 port is replaced, but this not helps.
>
> The kernel 2.6.16.1, 2.6.17-rc3-git1. (now i trying the latest rc and
git.)
> (I cannot try the 2.6.16 > kernels, because my sata card are unsupported
on
> older versions.)

It happens with the 2.6.17-rc5-git11 too. :-(
I gets more and more closer to can trigger this problem, and it looks like
an read error on one of my disks.
But without the error message, i cannot determine, wich are the tricky hdd.

>
> The dmesg log is  here from my node #1:
> http://download.netcenter.hu/bughunt/20060605/dmesg.txt
>
> I have compile the kernel with these debug options:
> [*] Magic SysRq key
> [*] Kernel debugging
> [*]   Collect scheduler statistics
> [*]   Mutex debugging, deadlock detection
> [*] Force gcc to inline functions marked 'inline'
> [*] Check for stack overflows
> (2) Stack backtraces per line
> [*] Debug page memory allocations
> [*] Write protect kernel read-only data structures
>
> Can somebody find and fix it?
>
> I can do almost anything to helping to debug!
>
>
> Thanks,
> Janos
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

