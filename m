Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317110AbSGNUkm>; Sun, 14 Jul 2002 16:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSGNUkl>; Sun, 14 Jul 2002 16:40:41 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:48069 "EHLO
	nymail01.e-steel.com") by vger.kernel.org with ESMTP
	id <S317110AbSGNUkk>; Sun, 14 Jul 2002 16:40:40 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: IDE/ATAPI in 2.5
Date: 14 Jul 2002 16:43:28 -0400
Organization: e-STEEL Netops news server
Message-ID: <xltn0sujb0v.fsf@shookay.newview.com>
References: <200207142004.g6EK4LaV019433@burner.fokus.gmd.de> <1026683185.13886.81.camel@irongate.swansea.linux.org.uk>
NNTP-Posting-Host: shookay.newview.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: nystorage01.e-steel.com 1026679408 12332 192.168.3.43 (14 Jul 2002 20:43:28 GMT)
X-Complaints-To: news@nystorage01.e-steel.com
NNTP-Posting-Date: Sun, 14 Jul 2002 20:43:28 +0000 (UTC)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox) writes:
> On Sun, 2002-07-14 at 21:21, Mathieu Chouquet-Stringer wrote:
> > I'm running tar (the regular version not star) right now on an Athlon @
> > 850. The fs is ext3 and the disk is a scsi drive.
> > So far, tar has been running for 17 min 25 sec, and that's what top says:
> > CPU states:  1.7% user, 98.2% system,  0.0% nice,  0.0% idle
>                  ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Why are using PIO mode devices ?

I'm using SCSI :
Jul 13 16:35:50 mcs kernel: SCSI subsystem driver Revision: 1.00
Jul 13 16:35:50 mcs kernel: PCI: Found IRQ 10 for device 00:0b.0
Jul 13 16:35:50 mcs kernel: sym.0.11.0: setting PCI_COMMAND_PARITY...
Jul 13 16:35:50 mcs kernel: sym0: <895> rev 0x1 on pci bus 0 device 11 function 0 irq 10
Jul 13 16:35:50 mcs kernel: sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
Jul 13 16:35:50 mcs kernel: sym0: SCSI BUS has been reset.
Jul 13 16:35:50 mcs kernel: spurious 8259A interrupt: IRQ7.
Jul 13 16:35:50 mcs kernel: scsi0 : sym-2.1.17a

And the drive on which I'm running the test

Jul 13 16:35:50 mcs kernel:   Vendor: IBM       Model: DDYS-T18350N Rev: S96H
Jul 13 16:35:50 mcs kernel:   Type:   Direct-Access                 ANSI SCSI revision: 03
[...]
Jul 13 16:35:51 mcs kernel: sym0:0:0: tagged command queuing enabled, command queue depth 32.
[...]
Jul 13 16:35:51 mcs kernel: sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
