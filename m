Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271649AbRHUMl3>; Tue, 21 Aug 2001 08:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271647AbRHUMlU>; Tue, 21 Aug 2001 08:41:20 -0400
Received: from ams8uucp0.ams.ops.eu.uu.net ([212.153.111.69]:22007 "EHLO
	ams8uucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S271646AbRHUMlB>; Tue, 21 Aug 2001 08:41:01 -0400
Date: Tue, 21 Aug 2001 14:38:04 +0200 (CEST)
From: kees <kees@schoen.nl>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Alexandre Hautequest <hquest@fesppr.br>, <linux-kernel@vger.kernel.org>
Subject: Re: IPX in 2.4.[5-9]
In-Reply-To: <20010821014517.G1394@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0108211436340.29582-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

While slist from 2.2.18 does indeed work with nwserv , nwuserlist does
not. it returns:

schoen3:/user2/download/www/ncpfs-2.2.0.18 # util/nwuserlist
util/nwuserlist: Unknown server (0x89FC) when initializing

schoen3:/user2/download/www/ncpfs-2.2.0.18 # util/slist

Known NetWare File Servers                          Network   Node Address
--------------------------------------------------------------------------
NW_SCHOEN                                           C0A80A28  000000000001

Kees


On Tue, 21 Aug 2001, Petr Vandrovec wrote:

> On Mon, Aug 20, 2001 at 06:37:05PM -0300, Alexandre Hautequest wrote:
> > Hello all.
> >
> > What's the actual IPX support in linux? Is it broken since 2.4.7? Or i just need
> > to recompile my tools against a new kernel version -- the old ones was compiled
> > in a 2.4.5 -- with any patch, option, whatever?
> >
> > hquest@condor:~$ dmesg
> > (snip)
> > IPX Portions Copyright (c) 1995 Caldera, Inc.
> > IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
> > hquest@condor:~$ /sbin/ifconfig -v eth0
> > eth0      Link encap:Ethernet  HWaddr 00:00:F8:08:BD:A1
> >           inet addr:172.16.40.2  Bcast:172.16.255.255  Mask:255.255.0.0
> >           IPX/Ethernet 802.2 addr:AC100000:0000F808BDA1
> > (snip)
> > hquest@condor:~$ slist
> > slist: Server not found (0x8847) in ncp_open
> > hquest@condor:~$ _
> >
> > Not flaming anyone, just questioning.
>
> If you do not have ncpfs-2.2.0.16, but anything newer, or older than 2.2.0.12,
> then it should work. If it reports 8847, it means that you have misconfigured
> network (search for 8847 on support.novell.com). You have either no server
> on 802.2, or you (or admin) disabled Reply To Get Nearest Server on all
> servers connected to your wire. You must enable it at least on one of them.
> 						Best regards,
> 							Petr Vandrovec
> 							vandrove@vc.cvut.cz
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

