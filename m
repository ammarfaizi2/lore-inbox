Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbTAJVlt>; Fri, 10 Jan 2003 16:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266270AbTAJVlt>; Fri, 10 Jan 2003 16:41:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8066 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266257AbTAJVlr>; Fri, 10 Jan 2003 16:41:47 -0500
Date: Fri, 10 Jan 2003 16:53:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Manish Lachwani <m_lachwani@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Using lilo to boot off any drive ...
In-Reply-To: <20030110213928.9073.qmail@web20508.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1030110164752.10638A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Manish Lachwani wrote:

> Richard,
> 
> Thanks for the response. 
> 
> Even if I can get the map information using the INT
> 0x13h disk interrupt, I would still need some way of
> knowing if sda has indeed failed. 
> 
> What I am thinking of if it is possible to make the
> "boot" option in lilo.conf variable. Or better,
> introduce a serial# option and the serial# can be
> scanned for on startup. Or make use of a lun# option. 
> 
> I was also thinking if BIOS id's for the disks can be
> used here. Are BIOS id's assigned for all drives?
> 
> Thanks
> Manish

It's a big "depends". Some SCSI controllers will assign BIOS
id's for everything found on the bus, starting at 0x80 for
an ID. Others don't. In fact, some will assign a CD/ROM to
0x00 (Drive A) even if it doesn't contain a boot record. When
that assignment occurs, it's space in the boot-order gets
filled in with the next available drive. It's a mess and you
can't count on anything except that 0x80 will be lowest numbered
"fixed-disk" drive found. That's why you should boot from it,
even if the BIOS allows you to boot from others.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


