Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbTCKUzK>; Tue, 11 Mar 2003 15:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261620AbTCKUzK>; Tue, 11 Mar 2003 15:55:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:900 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261619AbTCKUzI>; Tue, 11 Mar 2003 15:55:08 -0500
Date: Tue, 11 Mar 2003 16:08:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ben Collins <bcollins@debian.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire on Linux-2.4.20
In-Reply-To: <20030311204429.GD379@phunnypharm.org>
Message-ID: <Pine.LNX.3.95.1030311160016.8898B-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Mar 2003, Ben Collins wrote:

> > # cd drivers/ieee*
> > # ls *.o
> > csr.o	     hosts.o	 ieee1394_core.o	  nodemgr.o   pcilynx.o  sbp2.o
> > highlevel.o  ieee1394.o  ieee1394_transactions.o  ohci1394.o  raw1394.o
> > # ls -la pcilynx.o
> > -rw-r--r--   1 root     root        16432 Mar 11 15:30 pcilynx.o
> > # depmod pcilynx.o
> > depmod: *** Unresolved symbols in pcilynx.o
> > pcilynx.o:
> 
> > pcilynx.o: unresolved symbol i2c_transfer
> > pcilynx.o: unresolved symbol i2c_bit_del_bus
> > pcilynx.o: unresolved symbol i2c_bit_add_bus
> 
> Everything built fine this time. Redo "make modules" with the SUBDIRS
> option to get the rest built.
> 
> I strongly believe this is something local to your system. Maybe your
> system clock is wrong and it is confusing make. Maybe you don't have all
> the right tools installed. I'm not realy sure, but I do know it is not a
> problem in ieee1394 itself.
> 

Well it seems that I2C has to be configured into the kernel, not
a module, for it to get built. Something seems screwed up with
the configuration. I started, again, with a new kernel tree, configured
from scratch, answering all the questions in `make config` <whew>,
instead of `make oldconfig` with the previous ".config" file. At
least it looks like it might build the stuff. I am currently building
the base kernel (bzImage) again. The kernel builds fine. That's what
I am running. I just can't get all my stuff working because the ieee1394
hardware driver won't build.

The system clock is within a few seconds of NIST and is not set
during the day. It gets set at 2:00 AM every morning by crond. The
hardware clock is updated afterwards.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


