Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSHVSLC>; Thu, 22 Aug 2002 14:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSHVSLC>; Thu, 22 Aug 2002 14:11:02 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:37135 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315275AbSHVSLB>; Thu, 22 Aug 2002 14:11:01 -0400
Date: Thu, 22 Aug 2002 20:14:26 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Gonzalo Servat <gonzalo@unixpac.com.au>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ServerWorks OSB4 in impossible state
Message-ID: <20020822181426.GA11539@louise.pinerecords.com>
References: <Pine.LNX.4.10.10208220143440.11626-100000@master.linux-ide.org> <1030017756.9866.74.camel@biker.pdb.fsc.net> <20020822164527.GA11488@louise.pinerecords.com> <1030039170.3151.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030039170.3151.29.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 79 days, 8:36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > AFAIK 2.4.18 as well as 2.4.19-preEARLY seemed to work flawlessly w/ OSB4
> > even in DMA modes. How's the code there then? Is it dangerous to use?
> 
> Most of them work all the time (most OSB4, all CSB5. all CSB6)
> All of them work all the time with most drives
> Some of them do horrible things in UDMA with some drives (timing
> patterns I guess)
> 
> All of the OSB4 do MWDMA fine.

Oh it's not such a big problem then. If it tells you/Andre anything,
the controller I've run into trouble with seems to be (output from
2.4.19-pre2):

00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1880 [size=16]
00: 66 11 11 02 45 01 00 02 00 8a 01 01 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0

(This is what they put into the HP NetServer E800, which is otherwise a nice
machine -- With these we can get up to 8 NICs to work w/o IRQ sharing. Ideal
for building routers, except if we were to put SCSI drives everywhere, we'd
have nothing to eat soon enough.)

So far we've been ok as 2.4.19-pre2 indeed appears to work just fine in UDMA2.

T.
