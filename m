Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSA1Vof>; Mon, 28 Jan 2002 16:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286447AbSA1Vo0>; Mon, 28 Jan 2002 16:44:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27403 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286521AbSA1VoO>; Mon, 28 Jan 2002 16:44:14 -0500
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
To: akpm@zip.com.au (Andrew Morton)
Date: Mon, 28 Jan 2002 21:55:47 +0000 (GMT)
Cc: dan@debian.org (Daniel Jacobowitz), linux-kernel@vger.kernel.org,
        andrea@suse.de (Andrea Arcangeli)
In-Reply-To: <3C55C2AB.AE73A75D@zip.com.au> from "Andrew Morton" at Jan 28, 2002 01:29:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VJki-0001uO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the O_DIRECT/map_user_kiobuf case, we could end up asking
> the disk controller to perform busmastering against the video
> PCI device, which will probably explode somewhere down the chain.

Actually we already know if this will fail or not. Check the pci quirks file
We set a bunch of flags for safety issues on pci<->pci transfers. I did that
anticipating one day more than just a few capture cards would care

Alan
