Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbRLXQ62>; Mon, 24 Dec 2001 11:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285163AbRLXQ6S>; Mon, 24 Dec 2001 11:58:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62468 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285161AbRLXQ6L>; Mon, 24 Dec 2001 11:58:11 -0500
Subject: Re: Total system lockup with Alt-SysRQ-L
To: znmeb@aracnet.com ("M. Edward (Ed) Borasky")
Date: Mon, 24 Dec 2001 17:07:54 +0000 (GMT)
Cc: rmk@arm.linux.org.uk (Russell King), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112240621370.26289-100000@shell1.aracnet.com> from "M. Edward (Ed) Borasky" at Dec 24, 2001 06:27:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16IYZu-0004an-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> option, would be a one-button "sync up all the disks, forbid any more
> writes, save as much state as possbile (registers, memory) to a swap
> partition, set a flag for crash dump processing and reboot" capability.

Very hard to do - you can't trust the I/O systems state so the dump code
has to verify it hasnt been corrupted, reconfigure the drive it wishes to
write to, write the data out using its own non interrupt driven code and
then halt the box.

There are folks with patches that do a lot of that (lkcd)
