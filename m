Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282019AbRKZSxB>; Mon, 26 Nov 2001 13:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282438AbRKZSvx>; Mon, 26 Nov 2001 13:51:53 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:59164 "EHLO
	c0mailgw10.prontomail.com") by vger.kernel.org with ESMTP
	id <S282065AbRKZSup>; Mon, 26 Nov 2001 13:50:45 -0500
Message-ID: <3C028EE7.B9C07F8E@starband.net>
Date: Mon, 26 Nov 2001 13:50:15 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: 2.4.16 Bug (PPC)]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:

> On Mon, Nov 26, 2001 at 01:22:37PM -0500, war wrote:
>
> > This is the actual SCSI driver I need for the 7200/90.
>
> What card did you throw in that box?  By default you'd want CONFIG_SCSI_MESH
> (internal) and CONFIG_SCSI_MAC53C94 (external).  For the ncr53c8xx stuff
> you would want CONFIG_SCSI_NCR53C8XX (low #s) or the sym_2 driver.
>
> > cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> > -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> > -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2
> > -Wno-uninitialized -mmultiple -mstring    -c -o 53c7,8xx.o 53c7,8xx.c
> > 53c7,8xx.c: In function `ncr_pci_init':
> > 53c7,8xx.c:1436: `is_prep' undeclared (first use in this function)
> > 53c7,8xx.c:1436: (Each undeclared identifier is reported only once
> > 53c7,8xx.c:1436: for each function it appears in.)
>
> I just fixed this for 2.2.20, so I'll do it for 2.4.16 shortly and
> submit to marcelo/maintainer of this file..  In short, 'is_prep' is
> bogus and should be (_machine == _MACH_prep).
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/

