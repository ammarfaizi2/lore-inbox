Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLAMHu>; Fri, 1 Dec 2000 07:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLAMHl>; Fri, 1 Dec 2000 07:07:41 -0500
Received: from mx1.port.ru ([194.67.23.32]:42250 "EHLO mx1.port.ru")
	by vger.kernel.org with ESMTP id <S129267AbQLAMHb>;
	Fri, 1 Dec 2000 07:07:31 -0500
From: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re[3]: DMA for triton again...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 143.167.4.62 via proxy [143.167.1.16]
Reply-To: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E141oUr-0006C9-00@f10.mail.ru>
Date: Fri, 01 Dec 2000 14:36:57 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> will try tonight... and will let you know tomorrow...
... Nop, it didn't work. Mike and everybody having experience / knowledge of Western Digital Caviar AC21600H... If you compare WD's documents at:
http://www.westerndigital.com/service/FAQ/dtr.html
and
http://www.westerndigital.com/products/non-current/drives/ac21600.html
they, respectively ,say:

UDMA if CCC is A8-AG (AH is not UDMA), D5-D7, Bx, or Cx All others -- PIO Mode 4

and

16.6 MB/s (burst Mode 4 PIO) *
16.6 MB/s (burst Mode 2 DMA) **
33.3 MB/s (Mode 2 Ultra DMA) ***

*Max PIO burst rate is specified at 16.6 MB/s using the IORDY signal. 
**Max DMA and multi-word DMA burst rate is specified using the DMARQ and DMACK signals.
***Mode 2 Ultra DMA is supported in the following firmware revisions (CCC Codes: A8, AA, AC, AD, AG, D5, D6, D7, Bx, Cx). 

Which one is true? Do non-UDMA AC21600H (I've got CCC F6) support DMA?

Is it possible to find out where hdparm -d1 is stopped? Maybe by compiling it with -g and debugging... As far as I understand, BIOS is not an issue, since ide.txt says, that Linux doesn't use BIOS when working with hard drives...

Thanks
Guennadi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
