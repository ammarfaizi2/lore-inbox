Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288572AbSADJtc>; Fri, 4 Jan 2002 04:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288562AbSADJtX>; Fri, 4 Jan 2002 04:49:23 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:28058 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288573AbSADJtJ>; Fri, 4 Jan 2002 04:49:09 -0500
Message-ID: <XFMail.20020104104843.R.Oehler@GDImbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20020104094546.O8673@suse.de>
Date: Fri, 04 Jan 2002 10:48:43 +0100 (MET)
From: R.Oehler@GDImbH.com
To: Jens Axboe <axboe@suse.de>
Subject: Re: kernel 2.4.17 crashes on SCSI-errors
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Keith Owens <kaos@ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04-Jan-2002 Jens Axboe wrote:
>> kernel BUG at /usr/src/linux-2.4.17-Dbg/include/asm/pci.h:147!
>> from [aic7xxx]ahc_linux_run_device_queue+0x39d
> 
> aic7xxx is calling pci_map_sg on either an unitialized scatterlist, or
> maybe just specifying too many segments. try and add a printk to print
> 'i' before the BUG() at line 147 in include/asm-i386/pci.h

Line 147 now reads: {printk("nents=%d, i=%d\n",nents,i); BUG();}
and syslog buf yields:

<4>Incorrect number of segments after building list.
<4>nents=3, i=1.
<4>kernel BUG at /usr/src/linux-2.4.17-Dbg/include/asm/pci.h:147!


Regards,
        Ralf

 -----------------------------------------------------------------
|  Ralf Oehler
|  GDI - Gesellschaft fuer Digitale Informationstechnik mbH
|
|  E-Mail:      R.Oehler@GDImbH.com
|  Tel.:        +49 6182-9271-23 
|  Fax.:        +49 6182-25035           
|  Mail:        GDI, Bensbruchstraﬂe 11, D-63533 Mainhausen
|  HTTP:        www.GDImbH.com
 -----------------------------------------------------------------

time is a funny concept

