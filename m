Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293461AbSCSBnv>; Mon, 18 Mar 2002 20:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293465AbSCSBnl>; Mon, 18 Mar 2002 20:43:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18438 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293461AbSCSBnX>; Mon, 18 Mar 2002 20:43:23 -0500
Subject: Re: Linux 2.4.19-pre3-ac1
To: MrChuoi@yahoo.com
Date: Tue, 19 Mar 2002 01:55:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020319012940.430CC4E534@mail.vnsecurity.net> from "MrChuoi" at Mar 19, 2002 08:39:41 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16n8qw-0006dn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday 18 March 2002 06:44 pm, Alan Cox wrote:
> > > - 2.4.19-pre-ac: kswapd try to swap out and access disk continuously.
> > > Whole system is slow down and un-interactivable.
> >
> > echo "2" >/proc/sys/vm/overcommit_memory
> Couldn't load JBuilder (Out of memomy).

Good. Thats working - it stopped you even potentially getting out of memory
which is what that overcommit mode is supposed to do. Basically it'll stop
you before you risk OOM cases

> build and run my project from inside JBuilder. But OOM killer still doesn't
> work (2nd). Anyway, thank you. I will play with your Magic numbers later,
> Wizard ;). There are still alot of things to play with.

Rik is the wizard for the rmap oom. He posted a test patch to fix some OOM
logic. I'm just doing the code so you can decide OOM is not permitted to
occur 8)
