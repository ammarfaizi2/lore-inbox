Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275719AbRJJN1S>; Wed, 10 Oct 2001 09:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275720AbRJJN1J>; Wed, 10 Oct 2001 09:27:09 -0400
Received: from web12302.mail.yahoo.com ([216.136.173.100]:51725 "HELO
	web12302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275719AbRJJN1A>; Wed, 10 Oct 2001 09:27:00 -0400
Message-ID: <20011010132730.24028.qmail@web12302.mail.yahoo.com>
Date: Wed, 10 Oct 2001 06:27:30 -0700 (PDT)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: Re: 2.4.11: scsi problem 
To: monty@fismat1.fcfm.buap.mx
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

monty@fismat1.fcfm.buap.mx wrote:

I try to compile 2.4.11 and fail:

[...]
> cpqfcTSinit.o cpqfcTSinit.c
> cpqfcTSinit.c: In function `cpqfcTS_ioctl':
> cpqfcTSinit.c:663: `SCSI_IOCTL_FC_TARGET_ADDRESS' undeclared (first use in
> this function)
> cpqfcTSinit.c:663: (Each undeclared identifier is reported only once
> cpqfcTSinit.c:663: for each function it appears in.)
> cpqfcTSinit.c:681: `SCSI_IOCTL_FC_TDR' undeclared (first use in this
> function)

You could try this patch I made 

http://www.geocities.com/dotslashstar/cpqfc.html

Though it was made for 2.4.10-ac8, there's a reasonably good chance it
will still work.  This patch incidentally fixes the problem you mention, but
mainly the patch removes use of virt_to_bus and bus_to_virt from the cpqfc
driver.and uses the 2.4.x PCI DMA  interfaces instead.  (Note, I haven't tried
this patch with 2.4.11 yet myself).

-- steve (aka steve.cameron@compaq.com)


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
