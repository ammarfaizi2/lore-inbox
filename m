Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbTCKUeG>; Tue, 11 Mar 2003 15:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbTCKUeG>; Tue, 11 Mar 2003 15:34:06 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:27664 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261616AbTCKUeE>; Tue, 11 Mar 2003 15:34:04 -0500
Date: Tue, 11 Mar 2003 15:44:29 -0500
From: Ben Collins <bcollins@debian.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire on Linux-2.4.20
Message-ID: <20030311204429.GD379@phunnypharm.org>
References: <20030311200311.GB379@phunnypharm.org> <Pine.LNX.3.95.1030311152746.8672A-100000@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1030311152746.8672A-100000@chaos>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> # cd drivers/ieee*
> # ls *.o
> csr.o	     hosts.o	 ieee1394_core.o	  nodemgr.o   pcilynx.o  sbp2.o
> highlevel.o  ieee1394.o  ieee1394_transactions.o  ohci1394.o  raw1394.o
> # ls -la pcilynx.o
> -rw-r--r--   1 root     root        16432 Mar 11 15:30 pcilynx.o
> # depmod pcilynx.o
> depmod: *** Unresolved symbols in pcilynx.o
> pcilynx.o:

> pcilynx.o: unresolved symbol i2c_transfer
> pcilynx.o: unresolved symbol i2c_bit_del_bus
> pcilynx.o: unresolved symbol i2c_bit_add_bus

Everything built fine this time. Redo "make modules" with the SUBDIRS
option to get the rest built.

I strongly believe this is something local to your system. Maybe your
system clock is wrong and it is confusing make. Maybe you don't have all
the right tools installed. I'm not realy sure, but I do know it is not a
problem in ieee1394 itself.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
