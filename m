Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282962AbRK0VI2>; Tue, 27 Nov 2001 16:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282959AbRK0VIJ>; Tue, 27 Nov 2001 16:08:09 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:17414 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S282957AbRK0VH6>; Tue, 27 Nov 2001 16:07:58 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256B11.00740EA3.00@smtpnotes.altec.com>
Date: Tue, 27 Nov 2001 15:02:47 -0600
Subject: Re: 2.5.1-pre2 does not compile
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



drivers/scsi/ppa.c (the Iomega low-level parallel port SCSI driver) has the same
problem.

Wayne




f5ibh <f5ibh@db0bm.ampr.org> on 11/27/2001 02:44:29 PM

To:   linux-kernel@vger.kernel.org
cc:    (bcc: Wayne Brown/Corporate/Altec)

Subject:  2.5.1-pre2 does not compile



Hi,

I've the following error :

gcc -D__KERNEL__ -I/usr/src/kernel-sources-2.5.1-pre2/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-DMODULE -DMODVERSIONS -include
/usr/src/kernel-sources-2.5.1-pre2/include/linux/modversions.h   -c -o
aha1542.o aha1542.c
aha1542.c: In function `do_aha1542_intr_handle':
aha1542.c:423: `io_request_lock' undeclared (first use in this function)
aha1542.c:423: (Each undeclared identifier is reported only once
aha1542.c:423: for each function it appears in.)
aha1542.c: In function `aha1542_bus_reset':
aha1542.c:1479: `io_request_lock' undeclared (first use in this function)
aha1542.c: In function `aha1542_host_reset':
aha1542.c:1543: `io_request_lock' undeclared (first use in this function)
aha1542.c: At top level:
aha1542.c:114: warning: `setup_str' defined but not used
make[3]: *** [aha1542.o] Erreur 1
make[3]: Leaving directory `/usr/src/kernel-sources-2.5.1-pre2/drivers/scsi'
make[2]: *** [_modsubdir_scsi] Erreur 2
make[2]: Leaving directory `/usr/src/kernel-sources-2.5.1-pre2/drivers'
make[1]: *** [_mod_drivers] Erreur 2
make[1]: Leaving directory `/usr/src/kernel-sources-2.5.1-pre2'
make: *** [stamp-build] Erreur 2

-------
Regards
          Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




