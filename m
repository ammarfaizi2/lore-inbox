Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310443AbSCKRbV>; Mon, 11 Mar 2002 12:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310441AbSCKRbL>; Mon, 11 Mar 2002 12:31:11 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:10505 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S310443AbSCKRbC>; Mon, 11 Mar 2002 12:31:02 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200203111730.SAA23375@green.mif.pg.gda.pl>
Subject: Re: IDE on linux-2.4.18 (fwd)
To: root@chaos.analogic.com
Date: Mon, 11 Mar 2002 18:30:50 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203111707.g2BH7wU14696@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Mar 11, 2002 06:08:05 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I tried to install Linux-2.4.18 on a machine with IDE drives.
> The machine ran fine with Linux-2.4.1. It won't mount the
> root file-system because:
> 
> hda:	Cannot handle device with more than 16 heads giving up.
> 
> That's a real nice help. The device has 1024 cylinders, 255 heads
> and 63 sectors. This is 6,422 MB. An attempt to set 16 heads in
> the BIOS will allow access to only 528 MB, which is wrong.

Old hd.o driver supports:
- 1 IDE channel
- only CHS mode (no LBA)

It can address disk up to 8 GB, but a kernel parameter hd=... is required
if in is > 512 MB
It can boot from 512 MB area at the disk beginning, i.e. the area that can
be addressed by BIOS in this mode. 
( /boot should be located there if using lilo )

> So what is the magic incantation necessary to get the IDE
> subsystem to work like it used to?

Are you sure you need / want to use the old (ancient) driver ?

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
