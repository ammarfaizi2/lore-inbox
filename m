Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbRBEWto>; Mon, 5 Feb 2001 17:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBEWte>; Mon, 5 Feb 2001 17:49:34 -0500
Received: from winds.org ([207.48.83.9]:24068 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129036AbRBEWtS>;
	Mon, 5 Feb 2001 17:49:18 -0500
Date: Mon, 5 Feb 2001 17:47:31 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS stop/start problems (related to datagram shutdown bug?)
In-Reply-To: <E14PuLI-0004O8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102051746070.1586-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Alan Cox wrote:

> > Seems recently, on both redhat 6.1 and 7.0 using kernel 2.4.1-ac3, I
> > ran into this problem:
> 
> Ok seen this in older 2.2 but not 2.4
> 
> > nfsd: terminating on signal 9
> > svc: server socket destroy delayed
> > 
> > And restarting NFS has the following error message:
> > Starting NFS mountd:                                       [  OK  ]
> > Starting NFS daemon: nfssvc: Address already in use
> >                                                            [FAILED]
> 
> A socket got stuck. Thats preventing you restarting it. The bug is whatever
> leak caused the svc: server socket destroy delayed case. 
> 
> Just for reference what network card ?

Both machines had a 3c905b-tx-nm card in them.

3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and others.
http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905B Cyclone 100baseTx at 0x6100,  00:50:da:cd:c8:b9, IRQ 11
  product code 'XC' rev 00.13 date 12-29-99
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.

-Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
