Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262509AbRENVhM>; Mon, 14 May 2001 17:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262510AbRENVhC>; Mon, 14 May 2001 17:37:02 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15370 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262509AbRENVgu>; Mon, 14 May 2001 17:36:50 -0400
Subject: Re: Adaptec RAID SCSI 2100S
To: jpabuyer@tecnoera.com (Juan Pablo Abuyeres)
Date: Mon, 14 May 2001 22:33:18 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105141655590.4694-100000@baltazar.tecnoera.com> from "Juan Pablo Abuyeres" at May 14, 2001 05:31:48 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zPxu-0001Tr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> May 14 16:29:12 lala kernel: PARAMS_GET - Error:
> May 14 16:29:12 lala kernel:   ErrorInfoSize = 0x01, BlockStatus = 0x08,
> BlockSize = 0x0002
> May 14 16:29:12 lala kernel: PARAMS_GET - Error:
> May 14 16:29:12 lala kernel:   ErrorInfoSize = 0x01, BlockStatus = 0x08,
> BlockSize = 0x0002

This is OK. I am asking the card for tables and it is telling me it doesnt
have them

> May 14 16:29:12 lala kernel: scsi0 : i2o/iop0

Ok it found a scsi mode IOP

> May 14 16:29:12 lala kernel: sda : sense not available.

That might be my bug

> May 14 16:29:12 lala kernel: i2o_scsi: bus reset reply.
> May 14 16:29:12 lala kernel: sdb : READ CAPACITY failed.

And it struggles for some reason to get going. 

> May 14 16:29:12 lala kernel: Claim Claimed Mount Lock Ready.
> May 14 16:29:12 lala kernel: Flushing...Unlocking...Unlocked.
> May 14 16:29:12 lala kernel: Unclaim

Debugging..

> Then When I tried to fdisk /dev/sda (/dev/sda is a RAID1 of two
> Quantum disks) syslog shows this:

is /dev/sda the raid or the disks raw ?

> And issuing a fdisk:

Ok the geometry is different

> So, I don't know if I'm doing something wrong or what, but I haven't been
> able to get it working on 2.4.4 yet... please help.

Ok I need to put mroe disks and newer firmware on my card when I have some
time

