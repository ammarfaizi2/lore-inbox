Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288624AbSADNiB>; Fri, 4 Jan 2002 08:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288625AbSADNhw>; Fri, 4 Jan 2002 08:37:52 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:60490 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S288624AbSADNhn>; Fri, 4 Jan 2002 08:37:43 -0500
Date: Fri, 4 Jan 2002 15:37:21 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ASUS KT266A/VT8233 board and UDMA setting
Message-ID: <20020104153721.E1331@niksula.cs.hut.fi>
In-Reply-To: <20020104112834.A20724@suse.cz> <E16MSOG-0003ch-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16MSOG-0003ch-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 04, 2002 at 11:20:00AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 11:20:00AM +0000, you [Alan Cox] claimed:
> > > RH 2.4.2-x. That was before we had the official VIA solution to the chipset
> > > bug. It was better to be safe than sorry for an end user distro.
> > 
> > But ... did this (limiting UDMA to 2) stop the bug from being manifested?
> 
> Mostly yes. The VIA bug appears to be dependant on heavy PCI loading. Now
> we have a proper fix its all ok.

We are still seeing what seems to be Via PCI corruption when using HPT370 on
Abit-KT7-RAID. This is pretty high load (stream read/write two disks in
parallel.) It appears as 90-160 byte disk corruption.

It has been reproduced on 2.2.18pre19 + ide, 2.2.20+ide and 2.4.15.

We now seem to have found a BIOS setting that cures this for 2.2.20+ide.
The weird thing is that if we boot 2.2.21pre2+ide (pre2 includes the 2.4
backported VIA fixes), the corruption occurs.

We'll try to diff lspci -vvxxx outputs and post a more detailed report
shortly.


-- v --

v@iki.fi
