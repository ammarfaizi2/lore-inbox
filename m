Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271678AbRHUN4Q>; Tue, 21 Aug 2001 09:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271674AbRHUN4G>; Tue, 21 Aug 2001 09:56:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30225 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271670AbRHUNz6>; Tue, 21 Aug 2001 09:55:58 -0400
Subject: Re: massive filesystem corruption with 2.4.9
To: cwidmer@iiic.ethz.ch
Date: Tue, 21 Aug 2001 14:58:47 +0100 (BST)
Cc: kristian@korseby.net (Kristian), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Christian Widmer" at Aug 21, 2001 10:34:49 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZC3L-0007s7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Aug 21 09:01:06 adlib kernel: EXT2-fs error (device ide0(3,5)):
> > ext2_new_block: Allocating block in system zone - block =3D 3
> > Aug 21 09:01:06 adlib kernel: EXT2-fs error (device ide0(3,5)):
> > ext2_free_blocks: Freeing blocks in system zones - Block =3D 4, count=
>  =3D 1

Typically this indicates disk, memory or chipset problems. If your disk is
in UDMA33/66 mode you can pretty rule the disk out as the data is
protected

If you have a VIA chipset, especially if there is an SB Live! in the machine
then that may be the cause (fixes in 2.4.8-ac, should be a fix in 2.4.9 but
Linus tree also applies another bogus change but which should be harmless)

> > These fatal errors are occuring since 2.4.5 (2.4.8 I've not tested.).=
>  When
> > I work with 2.4.4 everything is fine !

What hardware
