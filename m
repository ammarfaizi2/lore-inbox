Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261579AbSJ1WKy>; Mon, 28 Oct 2002 17:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSJ1WJT>; Mon, 28 Oct 2002 17:09:19 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:29649 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261568AbSJ1WIr>; Mon, 28 Oct 2002 17:08:47 -0500
Subject: Re: [PATCHSET 17/23] add support for PC-9800 architecture (SCSI)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20021029023017.A2319@precia.cinet.co.jp>
References: <20021029023017.A2319@precia.cinet.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Oct 2002 22:33:51 +0000
Message-Id: <1035844431.1945.81.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-28 at 17:30, Osamu Tomita wrote:
> This is a part 17/23 of patchset for add support NEC PC-9800 architecture,
> against 2.5.44.

If all the BIOS mapping for the PC9800 is the same then intead of
patching the drivers add an

	if(pc98)
		pci98_bios_param(...)
	else
		host->bios_param()

change in the scsi core code not in each driver





