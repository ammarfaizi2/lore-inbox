Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSGNUnz>; Sun, 14 Jul 2002 16:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSGNUny>; Sun, 14 Jul 2002 16:43:54 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:54469 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S317112AbSGNUnx>; Sun, 14 Jul 2002 16:43:53 -0400
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <200207142004.g6EK4LaV019433@burner.fokus.gmd.de>
	<1026683185.13886.81.camel@irongate.swansea.linux.org.uk>
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 14 Jul 2002 16:45:55 -0400
In-Reply-To: <1026683185.13886.81.camel@irongate.swansea.linux.org.uk>
Message-ID: <xltfzymjaws.fsf@shookay.newview.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to copy lkml... :-(

alan@lxorguk.ukuu.org.uk (Alan Cox) writes:
> On Sun, 2002-07-14 at 21:21, Mathieu Chouquet-Stringer wrote:
> > I'm running tar (the regular version not star) right now on an Athlon @
> > 850. The fs is ext3 and the disk is a scsi drive.
> > So far, tar has been running for 17 min 25 sec, and that's what top says:
> > CPU states:  1.7% user, 98.2% system,  0.0% nice,  0.0% idle
>                  ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Why are using PIO mode devices ?

That's a scsi drive so I would guess it uses dma. The interface:
Jul 13 16:35:50 mcs kernel: sym.0.11.0: setting PCI_COMMAND_PARITY...
Jul 13 16:35:50 mcs kernel: sym0: <895> rev 0x1 on pci bus 0 device 11 function 0 irq 10
Jul 13 16:35:50 mcs kernel: sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
Jul 13 16:35:50 mcs kernel: sym0: SCSI BUS has been reset.
Jul 13 16:35:50 mcs kernel: spurious 8259A interrupt: IRQ7.
Jul 13 16:35:50 mcs kernel: scsi0 : sym-2.1.17a

And the drive:
Jul 13 16:35:50 mcs kernel:   Vendor: IBM       Model: DDYS-T18350N     Rev: S96H
Jul 13 16:35:50 mcs kernel:   Type:   Direct-Access                     ANSI SCSI revision: 03
[...]
Jul 13 16:35:51 mcs kernel: sym0:0:0: tagged command queuing enabled, command queue depth 32.
[...]
Jul 13 16:35:51 mcs kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
[...]
Jul 13 16:35:51 mcs kernel: sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
